import 'package:flutter/material.dart';
import '../home/channel_page.dart';


class VideoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VideoPageState();
  }

}

class VideoPageState extends State<VideoPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ChannelPage(channelCode: '"video"'),
    );
  }
}