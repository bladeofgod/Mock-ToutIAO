import 'package:shared_preferences/shared_preferences.dart';


class SpManager{

  SpManager._internal();
  static SpManager singleton = SpManager._internal();


  save(String key,Object value)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(value is String){
      preferences.setString(key, value);
    }else if(value is int){
      preferences.setInt(key, value);
    }else if(value is bool){
      preferences.setBool(key, value);
    }else if(value is double){
      preferences.setDouble(key, value);
    }else if(value is List<String>){
      preferences.setStringList(key, value);
    }
  }

  Future<String> getString(String key)async{
    var value;
    SharedPreferences prefs =await SharedPreferences.getInstance();
    value = prefs.getString(key);
    return value;
  }

  Future<int> getInt(String key)async{
    var value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getInt(key);
    return value;
  }
  Future<bool> getBool(String key) async {
    var value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getBool(key);
    return value;
  }
  Future<double> getDouble(String key) async {
    var value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getDouble(key);
    return value;
  }
  Future<List<String>> getListString(String key) async {
    var value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getStringList(key);
    return value;
  }

}