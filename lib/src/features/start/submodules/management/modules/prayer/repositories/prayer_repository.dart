import 'dart:io';

import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../../core/config/app_messages.dart';
import '../models/prayer_model.dart';
import 'interfaces/prayer_repository_interface.dart';

class PrayerRepository implements IPrayerRepository {
  final Dio _client;

  PrayerRepository(this._client);

  @override
  Future<Either<Failure, PrayerModel>> createPrayer(PrayerModel prayer) async {
    try {
      var response = await _client.post('/prayers',
          data: prayer.toJson(),
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.created) {
        var result = PrayerModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePrayer(String id) async {
    try {
      var response = await _client.delete('/prayers/$id',
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        return const Right(true);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  void dispose() {}

  @override
  Future<Either<Failure, PrayerModel>> getPrayer(String id) async {
    try {
      var response = await _client.get('/prayers/$id',
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var result = PrayerModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponsePrayers>> getPrayers(
      FilterOptions options) async {
    var url = "";
    if (options.name != null) {
      url = "/prayers?name=${options.name}";
    } else {
      url = '/prayers?page=${options.page}&sort=${options.sort}';
    }
    try {
      var response = await _client.get(url,
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var data = ResponsePrayers.fromJson(response.data);
        return Right(data);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseFindAllPrayers>> findAll() async {
    try {
      var response = await _client.get("/prayers/findAll",
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var data = ResponseFindAllPrayers.fromJson(response.data);
        return Right(data);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, PrayerModel>> updatePrayer(PrayerModel prayer) async {
    try {
      var response = await _client.patch('/prayers/${prayer.sId.toString()}',
          data: prayer.toJson(),
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var result = PrayerModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }
}
