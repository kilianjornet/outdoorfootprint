import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';

import '../../utils/api_manager.dart';

class PrivacyPolicyService extends GetConnect implements GetxService {
  Future<dynamic> privacyPolicy() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        throw StringManager.noConnection;
      }
      final response = await get(
        '${ApiManager.baseUrl}${ApiManager.privacyPolicy}',
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
