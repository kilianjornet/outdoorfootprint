import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/misc_services/refresh_token_service.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/token_manager.dart';

import '../../utils/api_manager.dart';

class MyFootprintService extends GetConnect implements GetxService {
  final refreshTokenService = RefreshTokenService();

  Future<dynamic> getUserFootprint() async {
    final token = await TokenManager.getAccessToken();
    final jwtAccessSecret = dotenv.env['JWT_ACCESS_SECRET'];

    try {
      JWT.verify('$token', SecretKey('$jwtAccessSecret'));
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        throw StringManager.noConnection;
      }
      final response = await get(
        '${ApiManager.baseUrl}${ApiManager.getUserFootprint}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var jsonResponse = jsonDecode(response.bodyString!);
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw (jsonResponse['message']);
      }
    } on JWTExpiredException {
      final token = await TokenManager.getRefreshToken();
      final refreshTokenResponse = await refreshTokenService.refreshToken(
        refreshToken: '$token',
      );
      await TokenManager.saveTokens(
        accessToken: refreshTokenResponse['access']['token'],
        refreshToken: refreshTokenResponse['refresh']['token'],
      );
      return await getUserFootprint();
    } on JWTException catch (e) {
      throw (e.message);
    } catch (e) {
      rethrow;
    }
  }
}
