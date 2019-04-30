

class Channel{

  static final int TYPE_MY = 1;
  static final int TYPE_OTHER = 2;
  static final int TYPE_MY_CHANNEL = 3;
  static final int TYPE_OTHER_CHANNEL = 4;

  String title;
  String channelCode;
  int itemType;


  Channel(String title,String channelCode,{itemType : 3}){
    this.title = title;
    this.channelCode = channelCode;
    itemType = itemType;
  }


}