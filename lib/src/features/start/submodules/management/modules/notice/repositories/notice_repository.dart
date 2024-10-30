import 'dart:io';

import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../../core/config/app_messages.dart';
import '../models/notice_model.dart';
import 'interfaces/notice_repository_interface.dart';

class NoticeRepository implements INoticeRepository {
  final Dio _client;

  NoticeRepository(this._client);

  @override
  Future<Either<Failure, NoticeModel>> createNotice(NoticeModel notice) async {
    try {
      var response = await _client.post('/notices',
          data: notice.toJson(),
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.created) {
        var result = NoticeModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteNotice(String id) async {
    try {
      var response = await _client.delete('/notices/$id',
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
  Future<Either<Failure, NoticeModel>> getNotice(String id) async {
    try {
      var response = await _client.get('/notices/$id',
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var result = NoticeModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseNotices>> getNotices(
      FilterOptions options) async {
    var url = "";
    if (options.name != null) {
      url = "/notices?name=${options.name}";
    } else {
      url = '/notices?page=${options.page}&sort=${options.sort}';
    }
    try {
      var response = await _client.get(url,
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var data = ResponseNotices.fromJson(response.data);
        return Right(data);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseFindAllNotices>> findAll() async {
    try {
      var response = await _client.get("/notices/findAll",
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var data = ResponseFindAllNotices.fromJson(response.data);
        return Right(data);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseWeeksAgenda>> getWeeksAgenda() async {
    try {
      var response = await _client.get("/notices/weeksAgenda",
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var data = ResponseWeeksAgenda.fromJson(response.data);
        return Right(data);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, NoticeModel>> updateNotice(NoticeModel notice) async {
    try {
      var response = await _client.patch('/notices/${notice.sId.toString()}',
          data: notice.toJson(),
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var result = NoticeModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }
}
