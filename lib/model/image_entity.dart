

class ImageEntity{
  /**
   * url : http://p3.pstatp.com/list/300x196/2c23000095ae9f56b15f.webp
   * width : 700
   * url_list : [{"url":"http://p3.pstatp.com/list/300x196/2c23000095ae9f56b15f.webp"},{"url":"http://pb9.pstatp.com/list/300x196/2c23000095ae9f56b15f.webp"},{"url":"http://pb1.pstatp.com/list/300x196/2c23000095ae9f56b15f.webp"}]
   * uri : list/2c23000095ae9f56b15f
   * height : 393
   */

  String url;
  int width;
  String uri;
  int height;
  List<UrlListBeanX> url_list;

  ImageEntity({
    this.url, this.width, this.uri, this.height, this.url_list
});

  static ImageEntity fromJson(Map<String,dynamic> json){
    var imageEntity = ImageEntity(
      url:json['url'],
      width: json['width'],
      uri: json['uri'],
      height: json['height'],
    );

    imageEntity.url_list = UrlListBeanX.parseUrlListBeanXs(json['url_list']);
    return imageEntity;

  }

  static List<ImageEntity> parseList(List<dynamic> list){
    List<ImageEntity> imageList = List();
    for(var i in list){
      ImageEntity entity = ImageEntity.fromJson(i);
      imageList.add(entity);
    }
    return imageList;
  }

  Map<String,dynamic> toJson() =>{
    'url': url,
    'width':width,
    'height' : height,
    'uri':uri,
    'url_list' : url_list
  };


}
 class UrlListBeanX {
  /**
   * url : http://p3.pstatp.com/list/300x196/2c23000095ae9f56b15f.webp
   */

  String url;

  UrlListBeanX({this.url});

  static UrlListBeanX fromJson(Map<String,dynamic> json){
    return UrlListBeanX(
      url: json['url'],
    );
  }
  Map<String,dynamic> toJson() =>{
    'url':url
  };

  static List<UrlListBeanX> parseUrlListBeanXs(List<dynamic> ulb){
    List<UrlListBeanX> urls = List();
    if(ulb!=null){
      for(var u in ulb){
        UrlListBeanX bean = UrlListBeanX(url: u['url']);
        urls.add(bean);
      }
    }
    return urls;
  }

}







