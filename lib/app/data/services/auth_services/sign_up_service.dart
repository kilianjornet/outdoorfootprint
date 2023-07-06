import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';

import '../../utils/api_manager.dart';

class SignUpService extends GetConnect implements GetxService {
  Future<dynamic> signUp({
    required String firstName,
    required String lastName,
    required String address,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        throw StringManager.noConnection;
      }
      final response = await post(
        '${ApiManager.baseUrl}${ApiManager.signUp}',
        {
          "firstName": firstName,
          "lastName": lastName,
          "address": address,
          "email": email,
          "phoneNumber": phoneNumber,
          "password": password,
          "confirmPassword": password,
          "isAgreeTermsAndServices": true,
        },
        headers: {
          'Content-Type': 'application/json',
        },
      );
      var jsonResponse = jsonDecode(response.bodyString!);
      if (response.statusCode == 201) {
        return jsonResponse;
      } else {
        throw (jsonResponse['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
