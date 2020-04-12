/*
kulina_app - api
created by: stefensuhat at 11 Apr 2020 16.06
*/
import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class Api {
  final JsonDecoder _decoder = JsonDecoder();

  String get baseUrl => 'https://kulina-recruitment.herokuapp.com';

  dynamic decodeResponse(d) {
    Response response = d;

    dynamic jsonBody = response.data;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new Exception("statusCode: $statusCode");
    }

    if (jsonBody is String && jsonBody != '') {
      return _decoder.convert(jsonBody);
    } else if (jsonBody == '') {
      final json = '{"success": true}';
      return _decoder.convert(json);
    } else {
      return jsonBody;
    }
  }

  // Global configuration
  Dio get dio {
    BaseOptions options = BaseOptions(baseUrl: baseUrl, connectTimeout: 15000);

    Dio dio = new Dio(options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      options.headers.addAll({
        'Accept': 'application/json',
      });
    }, onResponse: (Response response) async {
      final int statusCode = response.statusCode;

      Map results = {};

      if (statusCode == 200 || statusCode == 201 || statusCode == 204) {
        final dynamic decodeResponse = this.decodeResponse(response);
        bool responseIsList = decodeResponse is List;

        if (responseIsList) {
          final r = decodeResponse;
          return {'has_error': false, 'data': r};
        } else {
          final resultToAdd = decodeResponse;

          results.addAll(resultToAdd);

          return results;
        }
      }

      return response;
    }, onError: (DioError err) async {
      final Response response = err.response;
      print(err);
      if (response == null) {
        return dio.resolve(response);
      }

      if (response != null) {
        return dio.resolve({"has_error": true, ...response.data});
      }

      return err;
    }));

    return dio;
  }
}
