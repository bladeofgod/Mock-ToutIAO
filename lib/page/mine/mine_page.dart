import 'package:flutter/material.dart';


class MinePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MinePageState();
  }

}

class MinePageState extends State<MinePage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              //头像 黑色背景
              Container(
                height: 180,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 0,right: 10,left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: ClipOval(
                                  child: Image.asset('assets/my_avatar.jpg'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text("bladeofgod",style: TextStyle(fontSize: 12,color: Colors.white),),
                              ),
                            ],
                          ),
                          //point right arrow
                          Icon(Icons.arrow_forward_ios,color: Colors.white,),
                        ],
                      ),
                    ),
                    //动态 粉丝 访客 ...
                    Container(
                      margin: EdgeInsets.only(left: 15,right: 15,bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          //动态
                          Column(
                            children: <Widget>[
                              Text(
                                "0",style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '动态',style: TextStyle(color: Colors.grey,fontSize: 14),
                              ),
                            ],
                          ),
                          //粉丝
                          Column(
                            children: <Widget>[
                              Text(
                                "0",style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '粉丝',style: TextStyle(color: Colors.grey,fontSize: 14),
                              ),
                            ],
                          ),
                          //访客
                          Column(
                            children: <Widget>[
                              Text(
                                "0",style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '访客',style: TextStyle(color: Colors.grey,fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //收藏 历史 夜间
              Container(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //收藏
                    Column(
                      children: <Widget>[
                        Icon(Icons.star_border,color: Colors.red,),
                        Text(
                          '收藏',style: TextStyle(color: Colors.black,fontSize: 15),
                        ),
                      ],
                    ),
                    //历史
                    Column(
                      children: <Widget>[
                        Icon(Icons.history,color: Colors.deepOrange,),
                        Text(
                          '历史',style: TextStyle(color: Colors.black,fontSize: 15),
                        ),
                      ],
                    ),
                    //夜间
                    Column(
                      children: <Widget>[
                        Icon(Icons.airline_seat_individual_suite,color: Colors.lightBlueAccent,),
                        Text(
                          '夜间',style: TextStyle(color: Colors.black,fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //分割矩形
              Container(
                width: MediaQuery.of(context).size.width,
                height: 10,
                color: Colors.black12,
              ),
              //消息通知
              Container(
                alignment: Alignment.centerLeft,
                color: Colors.white,
                padding: EdgeInsets.all(18),
                child: Text('消息通知',style: TextStyle(fontSize: 18,color: Colors.black),),
              ),
              //分割矩形
              Container(
                width: MediaQuery.of(context).size.width,
                height: 10,
                color: Colors.black12,
              ),
              //商城
              Container(
                padding: EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('头条商城',style: TextStyle(fontSize: 18,color: Colors.black),),
                    Text('邀请好友得200元现金红包',style: TextStyle(fontSize: 14,color: Colors.black),),
                  ],
                ),
              ),
              //京东
              Container(
                padding: EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('京东特供',style: TextStyle(fontSize: 18,color: Colors.black),),
                    Text('新人领188红包',style: TextStyle(fontSize: 14,color: Colors.black),),
                  ],
                ),
              ),
              //分割矩形
              Container(
                width: MediaQuery.of(context).size.width,
                height: 10,
                color: Colors.black12,
              ),
              //爆料
              Container(
                alignment: Alignment.centerLeft,
                color: Colors.white,
                padding: EdgeInsets.all(18),
                child: Text('我要爆料',style: TextStyle(fontSize: 18,color: Colors.black),),
              ),
              //反馈
              Container(
                alignment: Alignment.centerLeft,
                color: Colors.white,
                padding: EdgeInsets.all(18),
                child: Text('用户反馈',style: TextStyle(fontSize: 18,color: Colors.black),),
              ),
              //设置
              Container(
                alignment: Alignment.centerLeft,
                color: Colors.white,
                padding: EdgeInsets.all(18),
                child: Text('系统设置',style: TextStyle(fontSize: 18,color: Colors.black),),
              ),
              //分割矩形
              Container(
                width: MediaQuery.of(context).size.width,
                height: 10,
                color: Colors.black12,
              ),
            ],
          ),
          Container(
            height: 100,
          ),
        ],
      ),
    );
  }
}