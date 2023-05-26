import 'package:shared_preferences/shared_preferences.dart';

class HeplerFunctions {
  static String userLoggedInKey = "userLoggedInKey";
  static String userNameKey = "userNameKey";
  static String userEmailKey = "userEmailKey";

  static Future<bool> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey)??false;
  }
}
