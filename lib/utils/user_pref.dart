import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static late SharedPreferences _prefs;
  factory UserPref() => UserPref._internal();
  UserPref._internal();
  static Future<void> init() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future close() => _prefs.clear();
  static set setUserUid(String uid) => _prefs.setString('uid', uid);
  static String get getUserUid => _prefs.getString('uid') ?? '';
  static Future remove() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
  }
}
