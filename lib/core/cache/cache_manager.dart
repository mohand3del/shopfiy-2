import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static late final SharedPreferences _pref;

  static init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) {
    return switch (value) {
      final String s => _pref.setString(key, s),
      final int i => _pref.setInt(key, i),
      final bool b => _pref.setBool(key, b),
      final double d => _pref.setDouble(key, d),
      _ => throw ArgumentError('Unsupported value type: ${value.runtimeType}'),
    };
  }

  static T? getData<T>({required String key}) {
    return _pref.get(key) as T?;
  }

  static Future<bool> clearData({required String key}) async {
    return await _pref.remove(key);
  }

  static Future<bool> clearAllData() async {
    return await _pref.clear();
  }
}
