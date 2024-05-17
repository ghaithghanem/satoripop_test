import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String tokenKey = "TOKEN";
  static const String rememberMeKey = "REMEMBER_ME";

  static String? storedToken;
  static bool? rememberMe;

  static Future<void> saveTokenAndRememberMe(String token, bool remember) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(tokenKey, token);
    await sharedPreferences.setBool(rememberMeKey, remember);
    storedToken = token;
    rememberMe = remember;
  }

  static Future<void> loadTokenAndRememberMe() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    storedToken = sharedPreferences.getString(tokenKey);
    rememberMe = sharedPreferences.getBool(rememberMeKey);
  }
  // Reset token
  static Future<void> resetToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(tokenKey, "");
    storedToken = null;
  }

  // load the current token into the variable storedToken
  static Future<void> loadToken() async {
    if (storedToken == null) {
      final sharedPreferences = await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString(tokenKey);
      if (token != null && token.isNotEmpty) {
        storedToken = token;
      }
    }
  }

  static Future<void> refreshToken() async {
    // TODO Implement
  }
}
