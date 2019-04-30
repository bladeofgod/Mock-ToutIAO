import 'package:flutter/material.dart';
import '../../constant/constant.dart';
import '../../model/channel.dart';
import '../../utils/sp.dart';
import 'dart:convert';
import '../../widget/async_snapshot_widget.dart';
import 'channel_page.dart';


class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin{

  TabController tabController;

  //List<Channel> _selectChannels;
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
      _selectChannels = Constant.getChannel();


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
    return Column(
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
      var page = ChannelPage(channelCode: code,);
      pages.add(page);
    });
    return pages;
  }






  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

















