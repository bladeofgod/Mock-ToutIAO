import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

class CookieUtil{

  static Future<String> getCookiePath()async{
    Directory directory = await getTemporaryDirectory();
    String temp = directory.path;
    return '$temp/cookies';
  }

  static Future<Null> deleteAllCookies() async{
    await getCookiePath().then((path){
      PersistCookieJar cookieJar = PersistCookieJar(dir: path);
      cookieJar.deleteAll();
    });
  }

}