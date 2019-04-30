

class TipEntity{
  /**
   * display_info : 今日头条推荐引擎有15条更新
   * open_url :
   * web_url :
   * app_name : 今日头条
   * package_name :
   * display_template : 今日头条推荐引擎有%s条更新
   * type : app
   * display_duration : 2
   * download_url :
   */

  String display_info;
  String open_url;
  String web_url;
  String app_name;
  String package_name;
  String display_template;
  String type;
  int display_duration;
  String download_url;

  TipEntity({
    this.display_info, this.open_url, this.web_url, this.app_name,
    this.package_name, this.display_template, this.type,
    this.display_duration, this.download_url
});

  static TipEntity fromJson(Map<String,dynamic> json){
    var tip = TipEntity(
      display_info: json['display_info'],
      open_url: json['open_url'],
      web_url: json['web_url'],
      app_name: json['app_name'],
      package_name: json['package_name'],
      display_template: json['display_template'],
      display_duration: json['display_duration'],
      type:json['type'],
      download_url: json['download_url']
    );
  }

  Map<String,dynamic> toJson() =>{
  'display_info':display_info,
  'open_url':open_url,
  'web_url':web_url,
  'app_name':app_name,
  'package_name':package_name,
  'display_template':display_template,
  'display_duration':display_duration,
  'type':type,
  'download_url':download_url
  };


}

















