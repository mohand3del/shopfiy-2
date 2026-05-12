import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCacheManager {
  static late FlutterSecureStorage secureStorage;
  static init() async {
    secureStorage = const FlutterSecureStorage();
  }

  static Future<String?> getSecureData({required String key}) async {
    return await secureStorage.read(key: key);
  }

  static Future<void> setSecureData({
    required String key,
    required String value,
  }) async {
    await secureStorage.write(key: key, value: value);
  }

  static Future<void> deleteSecureData({required String key}) async {
    await secureStorage.delete(key: key);
  }

  /// Delete all
  static Future<void> deleteAllSecureData() async {
    await secureStorage.deleteAll();
  }
}
