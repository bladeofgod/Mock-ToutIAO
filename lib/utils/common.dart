import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'sp.dart';
import 'textsize.dart';
import '../widget/expand_button.dart';


class CommonUtil {
  //加载弹窗
  static Future showLoadingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            color: Colors.transparent,
            child: WillPopScope(
                child: Center(
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: SpinKitCubeGrid(color: Colors.white),
                        ),
                        Container(
                          height: 1.0,
                        ),
                        Container(
                          child: Text(
                            '加载中...',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onWillPop: () => Future.value(false)),
          );
        });
  }

  //显示普通弹窗
  //通过valuechange 可以对 commitMaps进行1对1监听 具体可以看注释
  static Future<Null> showCommitOptionDialog(BuildContext context, String title,
      String content, List<String> commitMaps, ValueChanged<int> onTap,
      {width = 0,
      height = 200.0,
      List<Color> bgColorList,
      List<Color> colorList}) {
    return showDialog(context: context,
        builder: (BuildContext context){
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: width == 0? MediaQuery.of(context).size.width * 3/4 : width,
            height: height,
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color:Colors.white,borderRadius: BorderRadius.circular(4.0)
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    title ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:Colors.deepOrange,
                      fontSize:TextSizeConst.normalTextSize
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(padding: EdgeInsets.all(10),
                    child: Text(content,textAlign: TextAlign.center,style: TextStyle(
                      color:Colors.grey,fontSize:TextSizeConst.smallTextSize
                    ),),),
                  ),
                ),
                Row(
                  children: commitMaps.map((str){
                    var index = commitMaps.indexOf(str);
                    return ExpandButton(
                      maxLines: 1,
                      mainAxisAlignment: MainAxisAlignment.start,
                      fontSize: 14,
                      color: bgColorList.length >0 ? bgColorList[index] : Theme.of(context).primaryColor,
                      text: str,
                      textColor: colorList != null ? colorList[index] :  Colors.grey,
                      onPress: (){
                        Navigator.pop(context);
                        onTap(index);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
        });
  }


  static Future push(BuildContext context,Widget widget){
    Future result = Navigator.push(context, new MaterialPageRoute(builder: (context)=>widget));
    return result;
  }

  static Future pushIOS(BuildContext context, Widget widget){
    Future result = Navigator.push(context, CupertinoPageRoute(builder: (context){
        return widget;
    }));
    return result;
  }


//  static Future<bool> isLogin() async{
//    var id = await SpManager.singleton.getInt(Const.ID);
//    return id != null && id >0;
//  }





}















