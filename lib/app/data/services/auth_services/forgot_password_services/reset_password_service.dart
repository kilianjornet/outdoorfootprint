import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../../utils/api_manager.dart';
import '../../../utils/string_manager.dart';

class ResetPasswordService extends GetConnect implements GetxService {
  Future<dynamic> resetPassword({
    required String token,
    required String password,
  }) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        throw StringManager.noConnection;
      }
      final response = await post(
        '${ApiManager.baseUrl}${ApiManager.resetPassword}',
        {
          "token": token,
          "password": password,
        },
        headers: {
          'Content-Type': 'application/json',
        },
      );
      var jsonResponse = jsonDecode(response.bodyString!);
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw (jsonResponse['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
