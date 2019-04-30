import 'package:flutter/material.dart';


class FlashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FlashPageState();
  }


}

class FlashPageState extends State<FlashPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4)).whenComplete((){
      Navigator.pushReplacementNamed(context, 'main_page');
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 60,left:40,right: 40 ),
          child: Image.asset('assets/splash_banner.png',fit: BoxFit.fitWidth,),
        )
      ),
    );
  }
}