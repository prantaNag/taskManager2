import 'dart:convert';

import 'package:http/http.dart';
import 'package:taskmanager/data/models/network_response.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(
        Uri.parse(url),
      );
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
      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {'Content-type': 'Application/json'},
      );
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
}
