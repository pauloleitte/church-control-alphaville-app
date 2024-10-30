import 'dart:io';

import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


import '../../../../../../../core/config/app_messages.dart';
import '../models/member_model.dart';
import 'interfaces/member_repository_interface.dart';

class MemberRepository implements IMemberRepository {
  final Dio _client;

  MemberRepository(this._client);

  @override
  Future<Either<Failure, MemberModel>> createMember(MemberModel member) async {
    try {
      var response = await _client.post('/members',
          data: member.toJson(),
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.created) {
        var result = MemberModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMember(String id) async {
    try {
      var response = await _client.delete('/members/$id',
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
  Future<Either<Failure, MemberModel>> getMember(String id) async {
    try {
      var response = await _client.get('/members/$id',
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var result = MemberModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseMembers>> getMembers(
      FilterOptions options) async {
    var url = "";
    if (options.name != null) {
      url = "/members?name=${options.name}";
    } else {
      url = '/members?page=${options.page}&sort=${options.sort}';
    }
    try {
      var response = await _client.get(url,
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var data = ResponseMembers.fromJson(response.data);
        return Right(data);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseFindAllMembers>> findAllMembers() async {
    try {
      var response = await _client.get("/members/findAll",
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var data = ResponseFindAllMembers.fromJson(response.data);
        return Right(data);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, MemberModel>> updateMember(MemberModel member) async {
    try {
      var response = await _client.patch('/members/${member.sId.toString()}',
          data: member.toJson(),
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var result = MemberModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }
  
  @override
  Future<Either<Failure, ResponseBirthdayOfMonth>> getBirthdayOfMonth() async {
     try {
      var response = await _client.get("/members/birthday-of-month",
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var data = ResponseBirthdayOfMonth.fromJson(response.data);
        return Right(data);
      }
      return Left(DioFailure(message: AppMessages.ERROR_MESSAGE));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }
}
