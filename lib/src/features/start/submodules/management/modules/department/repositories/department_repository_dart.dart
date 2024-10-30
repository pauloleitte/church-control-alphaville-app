import 'dart:io';

import 'package:church_control/src/shared/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../../shared/utils/filter_options.dart';
import '../models/department_model.dart';
import 'interfaces/department_repository_interface.dart';

class DepartmentRepository implements IDepartmentRepository {
  final Dio _client;

  DepartmentRepository(this._client);

  @override
  Future<Either<Failure, DepartmentModel>> createDepartment(
      DepartmentModel model) async {
    try {
      var response = await _client.post('/departments',
          data: model.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.created) {
        var result = DepartmentModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteDepartment(String id) async {
    try {
      var response = await _client.delete('/departments/$id',
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        return const Right(true);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, DepartmentModel>> getDepartment(String id) async {
    try {
      var response = await _client.get('/departments/$id',
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = DepartmentModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, DepartmentModel>> updateDepartment(
      DepartmentModel model) async {
    try {
      var response = await _client.patch('/departments/${model.sId}',
          data: model.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = DepartmentModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseDepartments>> getDepartments(
      FilterOptions options) async {
    var url = "";
    if (options.name != null) {
      url = "/departments?name=${options.name}";
    } else {
      url = '/departments?page=${options.page}&sort=${options.sort}';
    }
    try {
      var response = await _client.get(url,
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var departments = ResponseDepartments.fromJson(response.data);
        return Right(departments);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  void dispose() {}
}
