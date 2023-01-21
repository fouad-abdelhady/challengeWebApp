import 'dart:convert';

import 'package:dio/dio.dart';

import './services_error_codes.dart';

import '../../../constatnts/costants.dart';
import '../../../utils/utils.dart';

class Services with ServiceErrors {
  static const baseUrl = "https://challenge-backend.up.railway.app/";
  static final Services _services = Services._internal();
  String? token = "";
  late Dio _dio;
  late Utils _utils;

  factory Services() {
    return _services;
  }
  Services._internal() {
    _dio = Dio(_options);

    _utils = Utils();
  }

  BaseOptions get _options => BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true);

  Future<Response> getRequest(
      {required String route, Map<String, dynamic>? parameters}) async {
    try {
      bool isThereConnection = await _utils.isNetworkAvailable();

      if (!isThereConnection) {
        return Future.error(RegularServicesErrors.noConnection);
      }
      final response = await _dio.get(route,
          queryParameters: parameters,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      return response;
    } catch (e) {
      if (e is DioError) {
        return await identifiyError(e);
      }
      return Future.error(RegularServicesErrors.requestError);
    }
  }

  Future<Response> postRequest(
      {required String route, required Map<String, dynamic> body}) async {
    print("test route");
    try {
      bool isThereConnection = await _utils.isNetworkAvailable();

      if (!isThereConnection) {
        return Future.error(RegularServicesErrors.noConnection);
      }
      var requestBody = jsonEncode(body);

      final response = await _dio.post(route,
          data: requestBody,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } catch (e) {
      if (e is DioError) {
        print("dio error");
        return await identifiyError(e);
      }
      return Future.error(RegularServicesErrors.requestError);
    }
  }
}
