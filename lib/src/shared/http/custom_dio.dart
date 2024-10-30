import 'package:dio/dio.dart';
import '../../core/config/app_constants.dart';
import 'interceptors/custom_interceptor.dart';

Dio createDio() {
  final dio = Dio(BaseOptions(
    receiveTimeout: 5000,
    baseUrl: AppConstants.API_URL,
  ));

  dio.interceptors.add(CustomInterceptors());
  return dio;
}
