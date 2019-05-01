
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class WebPage extends StatefulWidget{

  String title;
  String url;

  WebPage({this.url,this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WebPageState();
  }

}

class WebPageState extends State<WebPage> {

  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged> onStateChanged;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebviewPlugin.close();
    //.listen 会返回一个StreamSubscription 以此来监听webview state具体可参见StreamSubscription 的注释
    onStateChanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state){
      switch(state.type){
        case WebViewState.shouldStart:
        // 准备加载
          print("准备加载");
          break;
        case WebViewState.startLoad:
        // 开始加载
          print("开始加载");
          break;
        case WebViewState.finishLoad:
        // 加载完成
          print("加载完成");
          break;
        case WebViewState.abortLoad:
          break;
      }
    });

    flutterWebviewPlugin.onDestroy.listen((_){
      Navigator.of(context).pop();
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: WebviewScaffold(
        url: widget.url,
        withZoom: false,
        withLocalStorage: true,
        hidden: true,
        withJavascript: true,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    onStateChanged.cancel();
    flutterWebviewPlugin.close();
    super.dispose();
  }
}















