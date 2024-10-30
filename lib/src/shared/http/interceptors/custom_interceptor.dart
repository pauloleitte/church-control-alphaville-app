// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:church_control/src/core/config/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/auth/models/token_model.dart';
import '../../../core/auth/models/user_model.dart';
import '../../../core/auth/services/interfaces/token_service_interface.dart';
import '../../../core/auth/services/interfaces/user_service_interface.dart';

class CustomInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey("requiresToken")) {
      var tokenService = Modular.get<ITokenService>();
      var token = await tokenService.getCurrentToken();

      if (token.accessToken != null && token.accessToken!.isNotEmpty) {
        var headerAuth = genToken(token.accessToken);
        options.headers['Authorization'] = headerAuth;
      }
      if (kDebugMode) {
        debugPrint(json.encode("BaseURL: ${options.baseUrl}"));
        debugPrint(json.encode("Endpoint: ${options.path}"));
        if (options.headers['Authorization'] != null) {
          debugPrint("Authorization: ${options.headers['Authorization']}");
        }
        if (options.data != null) {
          debugPrint("Payload ${json.encode(options.data)}");
        }
      }
      return super.onRequest(options, handler);
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != null) {
      if (err.response!.statusCode! >= 400 &&
          err.response!.statusCode! <= 499) {
        return super.onError(err, handler);
      }
      if (err.response?.statusCode == 500) {
        return super.onError(err, handler);
      } else {
        logout();
      }
    }
    if (err.error.runtimeType != 'String') {
      logout();
    }
    return super.onError(err, handler);
  }

  String genToken(String? token) {
    return 'Bearer $token';
  }

  void logout() {
    Modular.get<ITokenService>().saveTokenLocal(TokenModel());
    Modular.get<IUserService>().saveUserLocal(UserModel());
    Modular.to.navigate(AppRoutes.AUTH);
  }
}
