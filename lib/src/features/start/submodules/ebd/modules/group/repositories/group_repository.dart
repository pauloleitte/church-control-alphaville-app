import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/student/models/student_model.dart';
import 'package:church_control/src/core/auth/models/user_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../core/config/app_messages.dart';
import '../../../../../../../shared/utils/filter_options.dart';
import '../models/group_model.dart';
import 'interfaces/group_repository_interface.dart';

class GroupRepository implements IGroupRepository {
  final Dio _client;

  GroupRepository(this._client);

  @override
  Future<Either<Failure, GroupModel>> createGroup(GroupModel model) async {
    try {
      var response = await _client.post('/groups',
          data: model.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.created) {
        var result = GroupModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteGroup(String id) async {
    try {
      var response = await _client.delete('/groups/$id',
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
  Future<Either<Failure, GroupModel>> getGroup(String id) async {
    try {
      var response = await _client.get('/groups/$id',
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = GroupModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseGroups>> getGroups(
      FilterOptions options) async {
    var url = "";
    if (options.name != null && options.name!.isNotEmpty) {
      url = "/groups?name=${options.name}";
    } else {
      url = '/groups?page=${options.page}&sort=${options.sort}';
    }
    try {
      var response = await _client.get(url,
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = ResponseGroups.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateGroup(GroupModel model) async {
    try {
      var response = await _client.patch('/groups/${model.sId}',
          data: model.toJson(),
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
  void dispose() {}

  @override
  Future<Either<Failure, List<UserModel>>> getSecretariesByGroupId(
      String id) async {
    try {
      var response = await _client.get('/groups/$id/secretaries',
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = (response.data["secretaries"] as List)
            .map((e) => UserModel.fromJson(e))
            .toList();
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StudentModel>>> getStudentsByGroupId(
      String id) async {
    try {
      var response = await _client.get('/groups/$id/students',
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = (response.data["students"] as List)
            .map((e) => StudentModel.fromJson(e))
            .toList();
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getTeachersByGroupId(
      String id) async {
    try {
      var response = await _client.get('/groups/$id/teachers',
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = (response.data["teachers"] as List)
            .map((e) => UserModel.fromJson(e))
            .toList();
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GroupModel>>> getGroupsByUserId(String id) async {
    try {
      var response = await _client.get('/groups?userId=$id',
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result =
            (response.data as List).map((e) => GroupModel.fromJson(e)).toList();
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }
}
