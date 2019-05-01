import 'package:flutter/material.dart';
import '../home/channel_page.dart';
import '../../constant/constant.dart';
import '../../utils/sp.dart';
import 'dart:convert';


class VideoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VideoPageState();
  }

}

class VideoPageState extends State<VideoPage> with AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin {
  TabController tabController;

  Map<String,String> _selectChannels;
  Map<String,String> _unSelectChannels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectChannels = Map();
    _unSelectChannels = Map();

    checkChannel();

  }

  void checkChannel(){
    String selectChannelJson = '';
    String unSelectChannelJson = '';

    SpManager.singleton.getString(Constant.SELECTED_CHANNEL_JSON).then((sJson){
      selectChannelJson = sJson;
      setState(() {

      });
    });
    SpManager.singleton.getString(Constant.UNSELECTED_CHANNEL_JSON).then((unJson){
      unSelectChannelJson = unJson;
      setState(() {

      });
    });
    if(selectChannelJson.isEmpty || unSelectChannelJson.isEmpty){
      print("if select");
      _selectChannels = Constant.getVideoChannel();


      SpManager.singleton.save(Constant.SELECTED_CHANNEL_JSON, selectChannelJson);
    }else{
      _selectChannels = json.decode(selectChannelJson);
      _unSelectChannels = json.decode(unSelectChannelJson);
    }

    tabController = TabController(length: _selectChannels.length, vsync: this);

    print("select : " + _selectChannels.toString());
    print("un select :" + _unSelectChannels.toString());

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('视频',style: TextStyle(color: Colors.black,fontSize: 18),),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          Icon(Icons.video_call,color: Colors.blue,),
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          TabBar(
            indicatorColor: Colors.blueAccent,
            controller: tabController,
            isScrollable: true,
            tabs: parseTabs(),
          ),
          Expanded(
            flex: 1,
            child: TabBarView(
              controller: tabController,
              children: parsePages(),
            ),
          ),
        ],
      ),
    );
  }


  List<Widget> parseTabs(){
    List<Widget> tabs = List();
    _selectChannels.forEach((key,value){
      var tab = Tab(
        child: Text(
          '${key.replaceAll("\"", "")}',
          style: TextStyle(color: Colors.black,fontSize: 20),
        ),
      );
      tabs.add(tab);
    });
    return tabs;
  }

  parsePages(){
    List<ChannelPage> pages = List();
    _selectChannels.forEach((key,code){
      var page = ChannelPage(channelCode: code,isVideoPage: true,);
      pages.add(page);
    });
    return pages;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}