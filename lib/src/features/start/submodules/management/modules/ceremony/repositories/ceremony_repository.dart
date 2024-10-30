import 'dart:io';

import 'package:church_control/src/core/config/app_messages.dart';
import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../models/ceremony_model.dart';
import 'interfaces/ceremony_repository_interface.dart';

class CeremonyRepository implements ICeremonyRepository {
  final Dio _client;

  CeremonyRepository(this._client);

  @override
  Future<Either<Failure, CeremonyModel>> createCeremony(
      CeremonyModel model) async {
    try {
      var response = await _client.post('/ceremonys',
          data: model.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.created) {
        var result = CeremonyModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCeremony(String id) async {
    try {
      var response = await _client.delete('/ceremonys/$id',
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
  Future<Either<Failure, CeremonyModel>> getCeremony(String id) async {
    try {
      var response = await _client.get('/ceremonys/$id',
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = CeremonyModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, CeremonyModel>> updateCeremony(
      CeremonyModel model) async {
    try {
      var response = await _client.patch('/ceremonys/${model.sId}',
          data: model.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = CeremonyModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseCeremonies>> getCeremonies(
      FilterOptions options) async {
    var url = "";
    if (options.name != null) {
      url = "/ceremonys?name=${options.name}";
    } else {
      url = '/ceremonys?page=${options.page}&sort=${options.sort}';
    }
    try {
      var response = await _client.get(url,
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var data = ResponseCeremonies.fromJson(response.data);
        return Right(data);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CeremonyModel>>> getCeremoniesOfDay(
      DateTime date) async {
    try {
      final Map<String, dynamic> data = <String, dynamic>{};
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      data['date'] = formattedDate;
      var response = await _client.post('/ceremonys/of-day',
          data: data, options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.created) {
        var result = ResponseCeremonies.fromJson(response.data);
        return Right(result.ceremonies);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  void dispose() {}
}
