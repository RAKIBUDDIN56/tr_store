import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../API/api.dart';
import 'api_exceptions.dart';
import 'api_response.dart';

class ApiClient {
  Future<dynamic> get({required String url}) async {
    Response returnResponse;
    Map<String, String> headers = {};
    try {
      final response =
          await http.get(Uri.parse(url), headers: headers).timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          throw FetchDataException('Request timeout');
        },
      );
      returnResponse = Response(
          _returnResponse(response), response.statusCode, response.headers);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    debugPrint("$url::: RESPONSE=> ${returnResponse.statusCode}");
    return returnResponse;
  }

 

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.body.isNotEmpty) {
          return response.body;
        }
        return '';
      case 400:
      case 401:
      case 403:
      case 404:
      case 500:
        throw BadRequestException(response.body);
      default:
        throw FetchDataException(
            'Network error. StatusCode : ${response.statusCode}');
    }
  }
}
