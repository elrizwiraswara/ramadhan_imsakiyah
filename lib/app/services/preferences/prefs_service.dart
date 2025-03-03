import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

// Singleton Shared Preferences helper
class PrefsService {
  static final PrefsService _instance = PrefsService._();
  static SharedPreferences? _prefs;

  PrefsService._();

  factory PrefsService() {
    return _instance;
  }

  static Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static Future<bool?> setString(String key, String value) async {
    return await _prefs?.setString(key, value);
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  static Future<bool?> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value);
  }

  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  static Future<bool?> setInt(String key, int value) async {
    return await _prefs?.setInt(key, value);
  }

  static double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  static Future<bool?> setDouble(String key, double value) async {
    return await _prefs?.setDouble(key, value);
  }

  static Future<bool?> remove(String key) async {
    return await _prefs?.remove(key);
  }

  static Future<bool?> clear() async {
    return await _prefs?.clear();
  }
}
