import 'package:flutter/material.dart';
import '../constant/tab_name.dart';
import '../page/micro/micro_tt_page.dart';
import '../page/home/home_page.dart';
import '../page/mine/mine_page.dart';
import '../page/video/video_page.dart';
import 'package:fluttertoast/fluttertoast.dart';



class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainPageState();
  }

}

class MainPageState extends State<MainPage> {
  var appBarTitles;
  int currentIndex = 0;

  var pageController = PageController(initialPage: 0,keepPage: true);

  DateTime lastPressAt;//上次点击时间

  @override
  Widget build(BuildContext context) {

    appBarTitles = [
      TabName.TAB_NAME_1,TabName.TAB_NAME_2,TabName.TAB_NAME_3,TabName.TAB_NAME_4
    ];

    // TODO: implement build
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('今日头条'),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            HomePage(),
            VideoPage(),
            MicroTTPage(),
            MinePage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor:Colors.redAccent ,
          onTap: (index)=>tap(index),
          items: [
            BottomNavigationBarItem(
                title:Text(appBarTitles[0]),icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
                title: Text(appBarTitles[1]),icon: Icon(Icons.videocam)
            ),
            BottomNavigationBarItem(
                title: Text(appBarTitles[2]),icon: Icon(Icons.chat)
            ),
            BottomNavigationBarItem(
                title: Text(appBarTitles[3]),icon: Icon(Icons.account_circle)
            ),
          ],
        ),
      ),
      onWillPop: ()async{
        if(lastPressAt == null || DateTime.now().difference(lastPressAt) > Duration(seconds: 2)){
          lastPressAt = DateTime.now();
          Fluttertoast.showToast(msg: "再点击一次可退出应用");
          return false;
        }
        return true;
      },
    );
  }

  tap(int index){
    setState(() {
        currentIndex = index;
        pageController.jumpToPage(index);
    });
  }



}


















