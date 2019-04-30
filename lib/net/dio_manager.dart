
import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import '../utils/cookie_util.dart';
import '../utils/event_util.dart';
import '../model/result_data.dart';
import '../event/error_event.dart';
import '../model/news_data.dart';
import '../model/news_response.dart';


class DioManager{

  /**接口根地址*/
  static final String BASE_SERVER_URL = "http://is.snssdk.com/";
  static final String HOST_VIDEO = "http://i.snssdk.com";
  static final String URL_VIDEO="/video/urls/v/1/toutiao/mp4/%s?r=%s";

  static final String GET_ARTICLE_LIST = "api/news/feed/v62/?refer=1&count=20&loc_mode=4&device_id=34960436458&iid=13136511752";
  static final String GET_COMMENT_LIST = "article/v2/tab_comments/";

  //http://is.snssdk.com
  //http://is.snssdk.com/api/news/feed/v54/?refer=1&count=20&min_behot_time=1498722625&last_refresh_sub_entrance_interval=1498724693&loc_mode=4&tt_from=pull（tab_tip） 新闻列表
  //http://is.snssdk.com/article/v2/tab_comments/?group_id=6436886053704958466&item_id=6436886053704958466&offset=30&count=20 评论
  //http://is.snssdk.com/2/article/information/v21/ 详情



  Map<String,String> baseHeaders = {
  "User-Agent":"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.108 Safari/537.36 2345Explorer/8.0.0.13547",
  "Cache-Control":"max-age=0",
  "Upgrade-Insecure-Requests": "1",
  "X-Requested-With": "XMLHttpRequest",
  "Cookie" : "uuid=\"w:f2e0e469165542f8a3960f67cb354026\"; __tasessionId=4p6q77g6q1479458262778; csrftoken=7de2dd812d513441f85cf8272f015ce5; tt_webid=36385357187"
  };

  Dio _dio;

  DioManager._internal(){
    _dio = new Dio(
      Options(
        baseUrl: BASE_SERVER_URL,
        connectTimeout:10000,
        receiveTimeout:3000,
        headers: baseHeaders
      )
    );

    CookieUtil.getCookiePath().then((path){
      _dio.cookieJar = PersistCookieJar(dir: path);
    });


    _dio.interceptor.response.onError = (DioError e){
      EventUtil.eventBus.fire(e);
      return e;
    };

  }

  static DioManager singleton = DioManager._internal();


  factory DioManager() => singleton;

  get dio{
    return _dio;
  }


  Future<NewsResponse> get(url,{data,options,cancelToken}) async{
    Response response;
    NewsResponse resultData;

    try{
      response =  await _dio.get(
        url,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      print("response : $response");
      print("response data : ${response.data}");

      resultData = NewsResponse.fromJson(response.data);

//      if(resultData.code < 0){
//        EventUtil.eventBus.fire(ErrorEvent(resultData.errorCode,resultData.errorMsg));
//        resultData = null;
//      }

    }on DioError catch(e){
      if(CancelToken.isCancel(e)){
        print('get请求取消! ' + e.message);
      }
      print('get请求取消! ' + "$e");
    }
    return resultData;

  }




  Future<Response> getNormal(url,{data,options,cancelToken})async{
    Response response;
    try{
      response = await _dio.get(
          url,
          data: data,
          options: options,
          cancelToken: cancelToken
      );
    }on DioError catch(e){
      if(CancelToken.isCancel(e)){
        print('get请求取消! ' + e.message);
      }
      print('get请求取消! ' + "$e");
    }
    return response;
  }

  Future<ResultData> post(url,{data,options,cancelToken}) async{
    Response response;
    ResultData resultData;

    try{
      response = await _dio.get(
          url,
          data: data,
          options: options,
          cancelToken: cancelToken
      );

      resultData = ResultData.fromJson(
          response.data is String ? json.decode(response.data) : response.data
      );

      if(resultData.errorCode<0){
        EventUtil.eventBus.fire(ErrorEvent(resultData.errorCode,resultData.errorMsg));
        resultData = null;
      }

    }on DioError catch(e){
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
    }
    return resultData;

  }

  Future<Response> postNormal(url,{data,options,cancelToken})async{

    Response response;
    try{
      response = await _dio.get(
          url,
          data: data,
          options: options,
          cancelToken: cancelToken
      );
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
    }
    return response;

  }


}



















