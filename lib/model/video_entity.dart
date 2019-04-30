
import 'image_entity.dart';

class VideoEntity{
  /**
   * group_flags : 32832
   * video_type : 0
   * video_preloading_flag : 1
   * video_url : []
   * direct_play : 1
   * detail_video_large_image : {"url":"http://p1.pstatp.com/video1609/2130000392cc3ddb8076","width":580,"url_list":[{"url":"http://p1.pstatp.com/video1609/2130000392cc3ddb8076"},{"url":"http://pb3.pstatp.com/video1609/2130000392cc3ddb8076"},{"url":"http://pb9.pstatp.com/video1609/2130000392cc3ddb8076"}],"uri":"video1609/2130000392cc3ddb8076","height":326}
   * show_pgc_subscribe : 1
   * video_third_monitor_url :
   * video_id : eb0eab0d76274b13a3fd0649ba1d0f74
   * video_watching_count : 0
   * video_watch_count : 657298
   */

  int group_flags;
  int video_type;
  int video_preloading_flag;
  int direct_play;
  ImageEntity detail_video_large_image;
  int show_pgc_subscribe;
  String video_third_monitor_url;
  String video_id;
  int video_watching_count;
  int video_watch_count;
  List<dynamic> video_url;
  //自己新增的字段，记录视频播放的进度，用于同步视频列表也和详情页的进度
  int progress;
  String parse_video_url;

  VideoEntity({
    this.group_flags, this.video_type, this.video_preloading_flag,
    this.direct_play, this.detail_video_large_image, this.show_pgc_subscribe,
    this.video_third_monitor_url, this.video_id, this.video_watching_count,
    this.video_watch_count, this.video_url, this.progress,
    this.parse_video_url
}); //解析出来的视频地址

  static VideoEntity fromJson(Map<String,dynamic> json){

    //print("video entity : ${json['detail_video_large_image']}");

    var entity = VideoEntity(
      group_flags: json['group_flags'],
      video_type: json['video_type'],
      video_preloading_flag: json['video_preloading_flag'],
      direct_play: json['direct_play'],
      //detail_video_large_image: json['detail_video_large_image'],
      show_pgc_subscribe: json['show_pgc_subscribe'],
      video_third_monitor_url: json['video_third_monitor_url'],
      video_id: json['video_id'],
      video_watching_count: json['video_watching_count'],
      video_watch_count: json['video_watch_count'],
      video_url: json['video_url']
    );
    ImageEntity imageEntity = ImageEntity.fromJson(json['detail_video_large_image']);
    entity.detail_video_large_image = imageEntity;
    return entity;
  }

  static List<VideoEntity> parseList(List<dynamic> list){
    List<VideoEntity> entityList = List();
    for(var item in list){
      VideoEntity entity = VideoEntity.fromJson(item);
      entityList.add(entity);
    }
    return entityList;
  }

  Map<String,dynamic> toJson() =>{
    'group_flags':group_flags ,
  'video_type': video_type,
  'video_preloading_flag':video_preloading_flag ,
  'direct_play': direct_play,
  'detail_video_large_image':detail_video_large_image ,
  'show_pgc_subscribe': show_pgc_subscribe,
  'video_third_monitor_url': video_third_monitor_url,
  'video_id': video_id,
  'video_watching_count':video_watching_count ,
  'video_watch_count': video_watch_count,
  'video_url': video_url,
  };





}