import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:taskmanager/app.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/ui/controllers/auth_controlres.dart';
import 'package:taskmanager/ui/screens/sign_in_screen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url), headers: {
        'token': AuthControler.accessToken,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          inSuccess: true,
          responseData: decodeData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          inSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        inSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      debugPrint(url);
      debugPrint(body.toString());

      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-type': 'Application/json',
          'token': AuthControler.accessToken,
        },
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          inSuccess: true,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        redirectToLogIN();
        return NetworkResponse(
          statusCode: response.statusCode,
          inSuccess: false,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          inSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        inSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<void> redirectToLogIN() async {
    await AuthControler.clearAllData();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false);
  }
}
