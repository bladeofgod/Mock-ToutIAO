import 'package:flutter/material.dart';

typedef SuccessWidget = Widget Function(AsyncSnapshot snapshot);

class AsyncSnapshotWidget extends StatelessWidget{

  AsyncSnapshot snapshot;
  SuccessWidget successWidget;

  AsyncSnapshotWidget({this.snapshot,@required this.successWidget});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return parseSnap();
  }

  Widget parseSnap(){
    switch(snapshot.connectionState){
      case ConnectionState.none:
        return Center(child: Text('正在加载中...'),);
      case ConnectionState.active:
        return Center(child: CircularProgressIndicator(),);
      case ConnectionState.done:
        return successWidget(snapshot);
      case ConnectionState.waiting:
        return Center(child: CircularProgressIndicator(),);
      default: return null;
    }
  }

}




















