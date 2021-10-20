import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreference extends ChangeNotifier{
  static SharedPreferences _preferences;
  static const _emailKey = "emailKey";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setEmail(String email) async =>
      await _preferences.setString(_emailKey, email);

  static String getEmail()=>_preferences.getString(_emailKey);
  static void clear(){
    _preferences.clear();

  }
}
