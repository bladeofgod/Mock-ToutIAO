import 'user_entity.dart';
import 'video_entity.dart';
import 'image_entity.dart';

class News{
  /**
   * log_pb : {"impr_id":"201707061547030100080440135802B6"}
   * read_count : 628838
   * media_name : 电竞手游君
   * ban_comment : 0
   * abstract : 王者荣耀赛季结束的段位奖励一直以来都还是很给力的，除了免费的赛季限定皮肤之外（注：本次的赛季奖励皮肤获取方式为获得10场胜利游戏后自动获取）还有就是大把大把的钻石奖励了。那么这个钻石到底怎么用合适呢？
   * image_list : [{"url":"http://p3.pstatp.com/list/300x196/2c23000095ae9f56b15f.webp","width":700,"url_list":[{"url":"http://p3.pstatp.com/list/300x196/2c23000095ae9f56b15f.webp"},{"url":"http://pb9.pstatp.com/list/300x196/2c23000095ae9f56b15f.webp"},{"url":"http://pb1.pstatp.com/list/300x196/2c23000095ae9f56b15f.webp"}],"uri":"list/2c23000095ae9f56b15f","height":393},{"url":"http://p3.pstatp.com/list/300x196/2c2c0004688def37bb3c.webp","width":699,"url_list":[{"url":"http://p3.pstatp.com/list/300x196/2c2c0004688def37bb3c.webp"},{"url":"http://pb9.pstatp.com/list/300x196/2c2c0004688def37bb3c.webp"},{"url":"http://pb1.pstatp.com/list/300x196/2c2c0004688def37bb3c.webp"}],"uri":"list/2c2c0004688def37bb3c","height":393},{"url":"http://p1.pstatp.com/list/300x196/2c2a000049bb1a95374c.webp","width":699,"url_list":[{"url":"http://p1.pstatp.com/list/300x196/2c2a000049bb1a95374c.webp"},{"url":"http://pb3.pstatp.com/list/300x196/2c2a000049bb1a95374c.webp"},{"url":"http://pb9.pstatp.com/list/300x196/2c2a000049bb1a95374c.webp"}],"uri":"list/2c2a000049bb1a95374c","height":393}]
   * ugc_recommend : {"reason":"","activity":""}
   * article_type : 0
   * tag : news_game
   * forward_info : {"forward_count":0}
   * has_m3u8_video : 0
   * keywords : 韩信,王者荣耀,王者水晶,游戏,胜利游戏
   * rid : 201707061547030100080440135802B6
   * show_portrait_article : false
   * user_verified : 0
   * aggr_type : 1
   * cell_type : 0
   * article_sub_type : 0
   * bury_count : 3
   * title : 王者荣耀用段位奖励的钻石抽到王者水晶之后千万别急着换韩信
   * ignore_web_transform : 1
   * source_icon_style : 5
   * tip : 0
   * hot : 0
   * share_url : http://toutiao.com/a6436927152504258818/?iid=0&app=news_article
   * has_mp4_video : 0
   * source : 电竞手游君
   * comment_count : 902
   * article_url : http://toutiao.com/group/6436927152504258818/
   * filter_words : [{"id":"8:0","name":"看过了","is_selected":false},{"id":"9:1","name":"内容太水","is_selected":false},{"id":"5:1189115162","name":"拉黑来源:电竞手游君","is_selected":false},{"id":"3:306461185","name":"不想看:钻石","is_selected":false},{"id":"6:153758450","name":"不想看:王者荣耀","is_selected":false},{"id":"6:236362","name":"不想看:韩信","is_selected":false}]
   * share_count : 211
   * publish_time : 1498714396
   * action_list : [{"action":1,"extra":{},"desc":""},{"action":3,"extra":{},"desc":""},{"action":7,"extra":{},"desc":""},{"action":9,"extra":{},"desc":""}]
   * gallary_image_count : 4
   * cell_layout_style : 1
   * tag_id : 6436927152504259000
   * video_style : 0
   * verified_content :
   * display_url : http://toutiao.com/group/6436927152504258818/
   * large_image_list : []
   * media_info : {"user_id":59834611934,"verified_content":"","avatar_url":"http://p3.pstatp.com/large/216b000e0abb3ee9cb91","media_id":1567608882475010,"name":"电竞手游君","recommend_type":0,"follow":false,"recommend_reason":"","is_star_user":false,"user_verified":false}
   * item_id : 6436929317376099000
   * is_subject : false
   * show_portrait : false
   * repin_count : 1110
   * cell_flag : 11
   * user_info : {"verified_content":"","avatar_url":"http://p3.pstatp.com/thumb/216b000e0abb3ee9cb91","user_id":59834611934,"name":"电竞手游君","follower_count":0,"follow":false,"user_auth_info":"","user_verified":false,"description":"游戏 资讯 游戏攻略 你要的这里都有，来这里就对了。"}
   * source_open_url : sslocal://profile?uid=59834611934
   * level : 0
   * like_count : 19
   * digg_count : 19
   * behot_time : 1499325873
   * cursor : 1499325873999
   * url : http://toutiao.com/group/6436927152504258818/
   * preload_web : 0
   * user_repin : 0
   * has_image : true
   * item_version : 0
   * has_video : false
   * group_id : 6436927152504259000
   * video_duration: 68,
   * middle_image : {"url":"http://p3.pstatp.com/list/300x196/2c23000095ae9f56b15f.webp","width":700,"url_list":[{"url":"http://p3.pstatp.com/list/300x196/2c23000095ae9f56b15f.webp"},{"url":"http://pb9.pstatp.com/list/300x196/2c23000095ae9f56b15f.webp"},{"url":"http://pb1.pstatp.com/list/300x196/2c23000095ae9f56b15f.webp"}],"uri":"list/2c23000095ae9f56b15f","height":393}
   */

  int article_type;
  String tag;
  String title;
  int hot;
  String source;
  int comment_count;
  String article_url;
  int gallary_image_count;
  int video_style;
  int item_id;
  UserEntity user_info;
  int behot_time;
  String url;
  bool has_image;
  bool has_video;
  int video_duration;
  VideoEntity video_detail_info;
  int group_id;
  ImageEntity middle_image;
  List<ImageEntity> image_list;

  News({this.article_type, this.tag, this.title, this.hot, this.source,
    this.comment_count, this.article_url, this.gallary_image_count,
    this.video_style, this.item_id, this.user_info, this.behot_time, this.url,
    this.has_image, this.has_video, this.video_duration,
    this.video_detail_info, this.group_id, this.middle_image,
    this.image_list});


  static News fromJson(Map<String,dynamic> json){
    var news = News(
      article_type: json['article_type'],
      tag: json['tag'],
      title: json['title'],
      hot: json['hot'],
      source: json['source'],
      comment_count: json['comment_count'],
      article_url: json['article_url'],
      gallary_image_count: json['gallary_image_count'],
      video_style: json['video_style'],
      item_id: json['item_id'],
      behot_time: json['behot_time'],
      url: json['url'],
      has_image: json['has_image'],
      has_video: json['has_video'],
      video_duration: json['video_duration'],
      group_id: json['group_id']
    );
//    print('news data : ${json['user_info']}');
//    print('news data : ${json['video_detail_info']}');
//    print('news data : ${json['middle_image']}');
//    print('news data : ${json['image_list']}');
    news.user_info =
        json['user_info'] != null
            ? UserEntity.fromJson(json['user_info']) : null;
    news.video_detail_info =
        json['video_detail_info'] != null
            ? VideoEntity.fromJson(json['video_detail_info']) : null;
    news.middle_image =
        json['middle_image'] != null
            ? ImageEntity.fromJson(json['middle_image']) : null ;
    news.image_list =
        json['image_list'] != null ? ImageEntity.parseList(json['image_list']) : null ;

    return news;

  }

  Map<String,dynamic> toJson() => {
  'article_type':article_type,
  'tag' : tag,
  'title':title,
    'hot':hot,
    'source':source,
  'comment_count':comment_count,
  'article_url':article_url,
  'gallary_image_count':gallary_image_count,
  'video_style':video_style,
  'item_id':item_id,
  'behot_time':behot_time,
  'url':url,
  'has_image':has_image,
  'has_video':has_video,
  'video_duration':video_duration,
  'group_id':group_id,
  'user_info':user_info,
  'video_detail_info':video_detail_info,
  'middle_image':middle_image,
  'image_list':image_list
  };

}









