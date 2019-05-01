import 'package:flutter/material.dart';
import '../../model/result_data.dart';
import '../../model/news.dart';
import '../../model/news_data.dart';
import '../../model/news_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../widget/page_widget.dart';
import '../../net/dio_manager.dart';
import 'dart:convert';
import '../../constant/constant.dart';
import 'package:chewie/chewie.dart';//video player
import 'package:video_player/video_player.dart';
import '../../utils/crc32.dart';
import 'dart:math';
import '../../utils/common.dart';
import '../web_page.dart';
import 'package:matcher/matcher.dart';




class ChannelPage extends StatefulWidget{

  String channelCode = "\"\"";

  ChannelPage({@required this.channelCode});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChannelPageState();
  }

}

class ChannelPageState extends State<ChannelPage> with AutomaticKeepAliveClientMixin{

  int pageIndex = 1;
  RefreshController refreshController;
  PageStateController pageStateController;
  List<News> newsList = List();

  int lastTime;
  int currentTime;

  Map<int,VideoPlayerController> _mapVP = Map();
  Map<int,ChewieController> _mapCC = Map();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshController = RefreshController();
    pageStateController = PageStateController();

    getList(true);


  }


  void getList(bool isRefresh){
    if(lastTime == 0){
      lastTime = DateTime.now().millisecond;
    }
    currentTime = DateTime.now().millisecond;
    DioManager.singleton
        .get(DioManager.GET_ARTICLE_LIST,
        data: {'category':widget.channelCode.replaceAll("\"", ""),'min_behot_time':lastTime,'last_refresh_sub_entrance_interval':currentTime})
      .then((result){
        refreshController.sendBack(isRefresh, RefreshStatus.idle);
        print('news result + ${result.toString()}');
        if(result != null){
          pageStateController.changeState(PageState.LoadSuccess);
          print("news result.data  ${result.data}");

          var newsResponse = result;
          if(pageIndex == 1){
            newsList.clear();
          }
          if(! newsResponse.has_more){
            refreshController.sendBack(false, RefreshStatus.noMore);
          }

          setState(() {
            for(NewsData item in newsResponse.data){
              News news = News.fromJson(json.decode(item.content));
              newsList.add(news);
            }
          });

        }else{
          pageStateController.changeState(PageState.LoadFail);
        }
    });
  }

  void onRefresh(bool up){
    if(up){
      pageIndex = 1;
      getList(up);
    }else{
      pageIndex++;
      getList(up);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    if(_mapVP != null){
      _mapVP.forEach((key,value){
        value.dispose();
      });
    }
    if(_mapCC != null){
      _mapCC.forEach((key,value){
        value.dispose();
      });
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PageWidget(
      controller: pageStateController,
      reloadData: (){
        getList(true);
      },
      child: SmartRefresher(
          controller: refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context,index){
          if(widget.channelCode == '"video"'){
            print("channel code ${widget.channelCode}");
            //视频page
            return buildVideoItem(newsList[index],index);
          }else{
            print("channel code ${widget.channelCode}");
            //普通 page
            return buildItem(newsList[index]);
          }

        },
      ),),
    );
  }

  /*
  * 这里视频连接可能是空，需要进一步解析
  * 解析视频地址时 需要传入 item.url;
  * */

  void parseVideoUrl(String url){

    DioManager.singleton.getNormal(url).then((response){
      print("response data ${response.data}");
      print('response string ${response.toString()}');
      if(response != null){

        RegExp exp = RegExp(r"videoId: '(.+)'");
        Iterable<Match> matches = exp.allMatches(response.toString());
        String videoId = matches.first.group(0).replaceAll("\'", "").replaceAll(" ", "");

        print("video id $videoId");
        //1.将/video/urls/v/1/toutiao/mp4/{videoid}?r={Math.random()}，进行crc32加密。
        String r = getRandom();
        String s = "/video/urls/v/1/toutiao/mp4/$videoId?r=$r";
        print(s);
        //进行crc32加密。
        CRC32 crc32 = CRC32(mx: s);
        String crcString = crc32.getCRCString();
        //2.访问http://i.snssdk.com/video/urls/v/1/toutiao/mp4/{videoid}?r={Math.random()}&s={crc32值}
        String url = DioManager.HOST_VIDEO + s +"&s=" + crcString;

        DioManager.singleton
            .getNormal(url,
            data:{
              "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8",
              "Cookie" : "PHPSESSIID=334267171504; _ga=GA1.2.646236375.1499951727; _gid=GA1.2.951962968.1507171739; Hm_lvt_e0a6a4397bcb500e807c5228d70253c8=1507174305;Hm_lpvt_e0a6a4397bcb500e807c5228d70253c8=1507174305; _gat=1",
              "Origin" :"http://toutiao.iiilab.com"
            } ).then((result){
              print("result data : ${result.data}");
              print("resuilt to string ${result.toString()}");
              setState(() {
                _mapVP.forEach((key,value){
                  value = VideoPlayerController.network(
                    result.data.toString(),
                  );
                });
              });

        });
      }
    });
  }

  String getRandom() {
    Random random = new Random();
    String result = "";
    for (int i = 0; i < 16; i++) {
      result = result + random.nextInt(10).toString();
    }
    return result;
  }

  //视频条目
  //视频连接加密 暂时无法获得，视频可能无法播放
  Widget buildVideoItem(News item,int index){
    print("video url : ${item.video_detail_info.parse_video_url.toString()}");
    print("item url ${item.url}");
    String videoUrl = item.video_detail_info.parse_video_url;
    //parseVideoUrl(item.url);
//    if(videoUrl == null || videoUrl.isEmpty){
//      videoUrl = parseVideoUrl(item.url);
//    }

    _mapVP[index] =  VideoPlayerController.network(
      videoUrl,
    );
    _mapCC[index] = ChewieController(
      videoPlayerController: _mapVP[index],
      aspectRatio: 4/3,
      autoPlay: false,
      looping: false,
      placeholder: Image.network(item.video_detail_info.detail_video_large_image.url,
        width: MediaQuery.of(context).size.width,),
    ) ;

    return GestureDetector(
      onTap: (){
        //click
        CommonUtil.push(context, WebPage(url: item.article_url,));
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 230,
            child: Stack(
              children: <Widget>[
                //视频播放器
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Chewie(
                      controller:_mapCC[index],
                  ),
                ),
                // 视频标题 播放次数
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(15, 10, 30, 0),
                  //从上到下 渐变透明
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black87,Colors.black12]
                      )
                  ),
                  child: Column(
                    children: <Widget>[
                      //title
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${item.title}',
                          style: TextStyle(
                              fontSize: 14,color: Colors.white
                          ),
                        ),
                      ),
                      // play count
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                              item.video_detail_info.video_watch_count > 10000 ?
                              "${(item.video_detail_info.video_watch_count / 1000).floor()}万次播放"
                                  : "${item.video_detail_info.video_watch_count} 次播放",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //视频时长
                Positioned(
                  right: 20,
                  bottom: 40,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.black12,
                    child: Text(
                      getMinuteFromMill(item.video_duration),
                      style: TextStyle(fontSize: 8),
                    ),
                  ),
                ),

              ],
            ),
          ),
        //视频出处
          Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            color: Colors.white,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    //头像
                    ClipOval(
                      child: Image.network(
                          "${item.user_info.avatar_url}"
                      ),
                    ),
                    //作者
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        '${item.user_info.name}',
                        style: TextStyle(
                          fontSize:14,color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),

                //关注 评论 。。。
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: <Widget>[
                      // follow icon
                      Icon(Icons.local_play),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          "关注",
                          style: TextStyle(
                              fontSize:12,color: Colors.black
                          ),
                        ),
                      ),
                      //评论
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.chat_bubble_outline),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                "${item.comment_count}",
                                style: TextStyle(
                                  fontSize: 12,color: Colors.black
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      //省略号
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Icon(Icons.device_hub),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(
            color: Colors.white,
            height: 5,
            indent: 15,
          ),
        ],
      ),
    );
  }




  //普通条目
  Widget buildItem(News item){
    return GestureDetector(
      onTap: (){
        //goto web
        CommonUtil.push(context, WebPage(url: item.article_url,));
      },
      child: Column(
        children: <Widget>[
          classifyChild(item),
          Divider(
            color: Colors.grey,
            height: 1,
            indent: 15,
          ),
        ],
      ),
    );
  }

  Widget classifyChild(News item){
    if(item.has_video){
      //有视频
      if(item.video_style == 0){
        //右侧视频
        if(item.middle_image == null || item.middle_image.url.isEmpty){
          //纯文字布局(文章、广告)
          //TEXT_NEWS
          return buildTextNews(item);

        }
        //右侧小图布局(1.小图新闻；2.视频类型，右下角显示视频时长)
        //RIGHT_PIC_VIDEO_NEWS
        return buildRightPicVideoNews(item);


      }else if(item.video_style == 2){
        //居中大图布局(1.单图文章；2.单图广告；3.视频，中间显示播放图标，右侧显示时长)
        //居中视频    CENTER_SINGLE_PIC_NEWS
        return buildCenterSinglePicNews(item);

      }
    }else{
      //非视频新闻
      print('assetion bool ${item.has_image}');
      if(item.has_image == null || !item.has_image){
        //纯文字新闻
        //TEXT_NEWS
        return buildTextNews(item);

      }else{
        if(item.image_list == null || item.image_list.isEmpty){
          //图片列表为空，则是右侧图片
          //RIGHT_PIC_VIDEO_NEWS
          return buildRightPicVideoNews(item);
        }

        if(item.gallary_image_count == 3){
          //图片数为3，则为三图
          //THREE_PICS_NEWS
          return build3PicNews(item);
        }

        //中间大图，右下角显示图数
        //CENTER_SINGLE_PIC_NEWS
        return buildCenterSinglePicNews(item);

      }
    }
    //TEXT_NEWS
    return buildTextNews(item);
  }

  /**
   * 纯文字布局(文章、广告)
   * TEXT_NEWS
   */

  Widget buildTextNews(News item){

    bool isTop = newsList.indexOf(item) == 0 && widget.channelCode=="\"\"";//属于置顶
    bool isHot = item.hot == 1;//属于热点新闻
    bool isAD =(item.tag.isNotEmpty ? item.tag== Constant.ARTICLE_GENRE_AD : false);//属于广告新闻
    bool isMovie = (item.tag.isNotEmpty? item.tag == Constant.TAG_MOVIE : false);//影视


    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          //news title
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '${item.title}',
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18,color: Colors.black),
            ),
          ),
          //news bottom
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  // 标签： 置顶、热、广告、影视
                  buildLittleTag(isTop,isHot,isAD,isMovie),
                  //author
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      '${item.source}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                  //评论数
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      '${item.comment_count}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                  //时间
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      '${DateTime.fromMillisecondsSinceEpoch(item.behot_time)}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLittleTag(bool isTop,bool isHot,bool isAD,bool isMovie){
    if(isTop || isHot || isAD || isMovie){
      //显示
      if(isTop){
        Align align = Align(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
              height: 12,
              child: Container(
                color: Colors.pinkAccent,
                child: Text(
                  '置顶',style: TextStyle(fontSize: 9),
                ),
              )
          ),
        );
        return align;

      }else if(isHot){
        Align align = Align(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
              height: 12,
              child: Container(
                color: Colors.red,
                child: Text(
                  '热',style: TextStyle(fontSize: 9),
                ),
              )
          ));
        return align;


      }else if(isAD){

        Align align = Align(
          alignment: Alignment.bottomLeft,
          child: SizedBox(

              height: 12,
              child: Container(
                color: Colors.blue,
                child: Text(
                  '广告',style: TextStyle(fontSize: 9),
                ),
              )
          ) ,
        );

        return align;

      }else if(isMovie){

        Align align = Align(
          alignment: Alignment.bottomLeft,
          child:SizedBox(
              height: 12,
              child: Container(
                color: Colors.pinkAccent,
                child: Text(
                  '影视',style: TextStyle(fontSize: 9),
                ),
              )
          ) ,
        );

        return align;
        
      }
    }
    return SizedBox(
      width: 10,
    );
  }

  Widget playBtnWidget(News item){
    if(item.has_video){
      return Align(
        alignment: Alignment.center,
        child: Icon(
          Icons.play_circle_outline,
          color:Colors.grey,
          size: 60.0,
        ),
      );
//      return Positioned(
//        top: 90,
//        right: MediaQuery.of(context).size.width / 2,
//        child: Align(
//          alignment: Alignment.center,
//          child: Icon(
//            Icons.play_arrow,
//            color:Colors.grey,
//            size: 40.0,
//          ),
//        )
//      );
    }
    return SizedBox(width: 0,height: 0,);
  }

  Widget playDurationWidget(News item){
    if(item.has_video){
      return Align(
        alignment: Alignment.bottomRight,
        child: Container(
          padding: EdgeInsets.all(5),
          color: Colors.black12,
          child: Text(
            getMinuteFromMill(item.video_duration),
            style: TextStyle(fontSize: 8),
          ),
        ),
      );
//      return Positioned(
//        right: 40,
//        bottom: 40,
//        child: Align(
//          alignment: Alignment.bottomRight,
//          child: Container(
//            padding: EdgeInsets.all(5),
//            color: Colors.black12,
//            child: Text(
//              '${item.video_duration}',
//              style: TextStyle(fontSize: 8),
//            ),
//          ),
//        )
//      );
    }
    return SizedBox(width: 0,height: 0,);
  }



  /**
   * 居中大图布局(1.单图文章；2.单图广告；3.视频，中间显示播放图标，右侧显示时长)
   * CENTER_SINGLE_PIC_NEWS
   */
  Widget buildCenterSinglePicNews(News item){

    var screenSize = MediaQuery.of(context).size;

    bool isTop = newsList.indexOf(item) == 0 && widget.channelCode=="\"\"";//属于置顶
    bool isHot = item.hot == 1;//属于热点新闻
    bool isAD =  (item.tag.isNotEmpty ? item.tag== Constant.ARTICLE_GENRE_AD : false);//属于广告新闻
    bool isMovie = (item.tag.isNotEmpty ? item.tag == Constant.TAG_MOVIE : false);//影视

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          //标题
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '${item.title}',
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18,color: Colors.black),
            ),
          ),

          //content
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 180,
            width: screenSize.width,
            child: Stack(
              children: <Widget>[
                //video large image
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Image.network(
                    hasVideoOrGallery(item),
                    fit: BoxFit.contain,
                  ),
                ),
                //play icon
                playBtnWidget(item),
                //video 时长
                playDurationWidget(item),
              ],
            ),
          ),

          //bottom title
          buildLittleTag(isTop, isHot, isAD, isMovie),

        ],
      ),
    );
  }

  String hasVideoOrGallery(News item){
    if(item.has_video){
      return item.video_detail_info.detail_video_large_image.url;
    }else{
      return item.image_list[0].url.replaceAll("list/300x196", "large");
    }
  }


  /**
   * 右侧小图布局(1.小图新闻；2.视频类型，右下角显示视频时长)
   * RIGHT_PIC_VIDEO_NEWS
   */
  Widget buildRightPicVideoNews(News item){
    var screenSize = MediaQuery.of(context).size;

    bool isTop = newsList.indexOf(item) == 0 && widget.channelCode=="\"\"";//属于置顶
    bool isHot = item.hot == 1;//属于热点新闻
    bool isAD = (item.tag.isNotEmpty ? item.tag== Constant.ARTICLE_GENRE_AD : false);//属于广告新闻
    bool isMovie =(item.tag.isNotEmpty ? item.tag == Constant.TAG_MOVIE : false);//影视

    return Container(
      width: screenSize.width,
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          //左侧文字
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                //标题
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${item.title}',
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18,color: Colors.black),
                  ),
                ),
//                Expanded(
//                  flex: 1,
//                ),
                //bottom title
                buildLittleTag(isTop, isHot, isAD, isMovie),
              ],
            ),
          ),
          //右侧图片
          Container(
            width: 130,
            height: 80,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Image.network('${item.middle_image.url}',
                    fit: BoxFit.fill,)
                ),
                Positioned(
                  right: 5,
                  bottom: 10,
                  child: playBtnDurationWidget(item),
                ),

              ],
            ),
          ),
        ],
      ),
    );

  }

  Widget playBtnDurationWidget(News item){
    if(item.has_video){
      return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(2),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.play_arrow,
                color: Colors.black,
                size: 8,
              ),
              Container(
                margin: EdgeInsets.only(left: 2),
                child: Text(
                  getMinuteFromMill(item.video_duration),
                  style: TextStyle(fontSize: 8),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(width: 0,height: 0,);
  }

  String getMinuteFromMill(int duration){
    int minute = (duration / 60).floor();
    int second = duration - (minute * 60 );

    return "$minute : $second";

  }



  /**
   * 三张图片布局(文章、广告)
   * THREE_PICS_NEWS
   */
  Widget build3PicNews(News item){
    var screenSize = MediaQuery.of(context).size;

    bool isTop = newsList.indexOf(item) == 0 && widget.channelCode=="\"\"";//属于置顶
    bool isHot = item.hot == 1;//属于热点新闻
    bool isAD = (item.tag.isNotEmpty ? item.tag== Constant.ARTICLE_GENRE_AD : false);//属于广告新闻
    bool isMovie = (item.tag.isNotEmpty ? item.tag == Constant.TAG_MOVIE : false);//影视

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          //标题
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '${item.title}',
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18,color: Colors.black),
            ),
          ),
          //中间图片
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                //image 1
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 80,
                    child: Image.network(
                      '${item.image_list[0]}'
                    ),
                  ),
                ),
                //image 2
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 80,
                    child: Image.network(
                        '${item.image_list[1]}'
                    ),
                  ),
                ),
                //image 3
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 80,
                    child: Image.network(
                        '${item.image_list[2]}'
                    ),
                  ),
                ),
              ],
            ),
          ),

          //bottom info
          buildLittleTag(isTop, isHot, isAD, isMovie),

        ],
      ),
    );


  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}















