import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/token_manager.dart';

import '../../../utils/api_manager.dart';

class SendEmailService extends GetConnect implements GetxService {
  Future<dynamic> sendEmail({
    required String email,
  }) async {
    final token = await TokenManager.getAccessToken();
    final jwtAccessSecret = dotenv.env['JWT_ACCESS_SECRET'];

    try {
      final jwt = JWT.verify('$token', SecretKey('$jwtAccessSecret'));
      print('Payload: ${jwt.payload}');
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        throw StringManager.noConnection;
      }
      final response = await post(
        '${ApiManager.baseUrl}${ApiManager.sendEmail}',
        {
          "email": email,
        },
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
      print('jwt expired');
    } on JWTException catch (e) {
      throw (e.message);
    } catch (e) {
      rethrow;
    }
  }
}
