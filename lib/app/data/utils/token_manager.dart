import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  TokenManager._();

  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';
  static const String deviceTokenKey = 'deviceToken';

  static Future<void> saveTokens(
      {required String accessToken, required String refreshToken}) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(accessTokenKey, accessToken);
    await preferences.setString(refreshTokenKey, refreshToken);
  }

  static Future<void> saveDeviceToken({required String deviceToken}) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(deviceTokenKey, deviceToken);
  }

  static Future<String?> getAccessToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(refreshTokenKey);
  }

  static Future<String?> getDeviceToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(deviceTokenKey);
  }

  static Future<void> clearTokens() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(accessTokenKey);
    await preferences.remove(refreshTokenKey);
  }
}
