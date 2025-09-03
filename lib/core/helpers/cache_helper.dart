import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;

  /// Initialize before using anywhere (call in main)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save data
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) return await _prefs!.setString(key, value);
    if (value is int) return await _prefs!.setInt(key, value);
    if (value is bool) return await _prefs!.setBool(key, value);
    if (value is double) return await _prefs!.setDouble(key, value);
    return false;
  }

  /// Get data
  dynamic getData(String key) {
    return _prefs!.get(key);
  }

  /// Remove one key
  static Future<bool> removeData(String key) async {
    return await _prefs!.remove(key);
  }

  /// Clear all cache
  static Future<bool> clearAll() async {
    return await _prefs!.clear();
  }
}
