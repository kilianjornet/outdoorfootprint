import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  TokenManager._();

  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';

  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(accessTokenKey, accessToken);
    await preferences.setString(refreshTokenKey, refreshToken);
  }

  static Future<String?> getAccessToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(refreshTokenKey);
  }

  static Future<void> clearTokens() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(accessTokenKey);
    await preferences.remove(refreshTokenKey);
  }
}
