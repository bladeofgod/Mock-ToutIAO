

class Constant{
  /**已选中频道的json*/
  static final String SELECTED_CHANNEL_JSON = "selectedChannelJson";
  /**w未选频道的json*/
  static final String UNSELECTED_CHANNEL_JSON = "unselectChannelJson";

  /**频道对应的请求参数*/
  static final String CHANNEL_CODE = "channelCode";
  static final String IS_VIDEO_LIST = "isVideoList";

  static final String ARTICLE_GENRE_VIDEO = "video";
  static final String  ARTICLE_GENRE_AD = "ad";

  static final String TAG_MOVIE = "video_movie";

  static final String URL_VIDEO = "/video/urls/v/1/toutiao/mp4/%s?r=%s";

  /**获取评论列表每页的数目*/
  static final int COMMENT_PAGE_SIZE = 20;

  static final String DATA_SELECTED = "dataSelected";
  static final String DATA_UNSELECTED = "dataUnselected";


  /*
  * 获取默认频道
  * */

  static Map<String,String> getChannel(){
    Map<String,String> channel = Map();
    channel['\"推荐\"'] = '\"\"';
    channel["\"视频\""] = '\"video\"';
    channel["\"热点\""] = '\"news_hot\"';
    channel["\"社会\""] = '\"news_society\"';
    channel["\"娱乐\""] = '\"news_entertainment\"';
    channel["\"科技\""] = '\"news_tech\"';
    channel["\"汽车\""] = '\"news_car\"';
    channel["\"体育\""] = '\"news_sports\"';
    channel["\"财经\""] = '\"news_finance\"';
    channel["\"军事\""] = '\"news_military\"';
    channel["\"国际\""] = '\"news_world\"';
    channel["\"时尚\""] = '\"news_fashion\"';
    channel["\"游戏\""] = '\"news_game\"';
    channel["\"旅游\""] = '\"news_travel\"';
    channel["\"历史\""] = '\"news_history\"';
    channel["\"探索\""] = '\"news_discovery\"';
    channel["\"美食\""] = '\"news_food\"';
    channel["\"育儿\""] = '\"news_baby\"';
    channel["\"养生\""] = '\"news_regimen\"';
    channel["\"故事\""] = '\"news_story\"';
    channel["\"美文\""] = '\"news_essay\"';

    return channel;
  }

  /*
  * 获取视频 频道
  * */

  static Map<String,String> getVideoChannel(){
    Map<String,String> channel = Map();
    channel["\"推荐\""] = '\"video\"';
    channel["\"音乐\""] = '\"subv_voice\"';
    channel["\"搞笑\""] = '\"subv_funny\"';
    channel["\"社会\""] = '\"subv_society\"';
    channel["\"小品\""] = '\"subv_comedy\"';
    channel["\"生活\""] = '\"subv_life\"';
    channel["\"影视\""] = '\"subv_movie\"';
    channel["\"娱乐\""] = '\"subv_entertainment\"';
    channel["\"呆萌\""] = '\"subv_cute\"';
    channel["\"游戏\""] = '\"subv_game\"';
    channel["\"原创\""] = '\"subv_boutique\"';
    channel["\"开眼\""] = '\"subv_broaden_view\"';


    return channel;
  }
}













