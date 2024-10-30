import 'dart:io';

import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/models/lesson_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../core/config/app_messages.dart';
import 'interfaces/lesson_repositoy_interface.dart';

class LessonRepository implements ILessonRepository {
  final Dio _client;

  LessonRepository(this._client);

  @override
  Future<Either<Failure, bool>> createLesson(LessonModel lesson) async {
    try {
      var response = await _client.post('/lessons',
          data: lesson.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.created) {
        return const Right(true);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteLesson(String id) async {
    try {
      var response = await _client.delete('/lessons/$id',
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
  Future<Either<Failure, bool>> updateLesson(LessonModel lesson) async {
    try {
      var response = await _client.patch('/lessons/${lesson.sId}',
          data: lesson.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        return const Right(true);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, LessonModel>> getLesson(String id) async {
    try {
      var response = await _client.get('/lessons/$id',
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = LessonModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseLessons>> getLessons(
      FilterOptions options) async {
    var url = "";
    if (options.name != null && options.name!.isNotEmpty) {
      url = "/lessons?name=${options.name}";
    } else {
      url = '/lessons?page=${options.page}&sort=${options.sort}';
    }
    try {
      var response = await _client.get(url,
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = ResponseLessons.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseLessons>> getLessonsByGroupId(
      FilterOptions options) async {
    try {
      final url =
          '/lessons?page=${options.page}&sort=${options.sort}&groupId=${options.groupId}';
      var response = await _client.get(url,
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        return Right(ResponseLessons.fromJson(response.data));
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  void dispose() {}
}
