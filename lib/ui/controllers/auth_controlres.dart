import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/data/models/user_data_model.dart';

class AuthControler {
  static String accessToken = '';
  static UserModel? userdata;
  static const String _assessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  static Future<void> saveUserAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_assessTokenKey, token);
    accessToken = token;
  }

  static Future<String?> getUserAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_assessTokenKey);
  }

  static Future<void> clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  static Future<void> saveUserData(UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
      _userDataKey,
      jsonEncode(
        user.toJson(),
      ),
    );
  }

  static Future<UserModel?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(_userDataKey);
    if (data == null) return null;

    UserModel userModel = UserModel.fromJson(jsonDecode(data));
    return userModel;
  }

  static Future<bool> checkAuthState() async {
    String? token = await getUserAccessToken();

    if (token == null) return false;

    accessToken = token;
    userdata = await getUserData();
    return true;
  }
}
