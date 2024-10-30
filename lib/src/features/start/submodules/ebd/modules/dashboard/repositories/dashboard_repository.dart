import 'dart:io';

import 'package:church_control/src/core/config/app_messages.dart';
import 'package:dartz/dartz.dart';

import 'package:church_control/src/shared/errors/errors.dart';

import '../models/lighthouse_report_model.dart';

import '../models/daily_report_model.dart';
import 'package:dio/dio.dart';

import './interfaces/dashboard_repository_interface.dart';

class DashBoardRepository implements IDashBoardRepository {
  final Dio _client;

  DashBoardRepository(this._client);

  @override
  void dispose() {}

  @override
  Future<Either<Failure, List<DailyReport>>> getDailyReport(String date) async {
    try {
      var response = await _client.get('/dashboard/daily-report?date=$date',
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = (response.data as List)
            .map((e) => DailyReport.fromJson(e))
            .toList();
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LightHouseReport>>> getLightHouseReport(
      String date) async {
    try {
      var response = await _client.get('/dashboard/lighthouse-report?date=$date',
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = (response.data as List)
            .map((e) => LightHouseReport.fromJson(e))
            .toList();
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }
}
