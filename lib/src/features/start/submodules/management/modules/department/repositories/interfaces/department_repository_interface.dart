import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/department_model.dart';

abstract class IDepartmentRepository implements Disposable {
  Future<Either<Failure, ResponseDepartments>> getDepartments(
      FilterOptions options);
  Future<Either<Failure, DepartmentModel>> getDepartment(String id);
  Future<Either<Failure, DepartmentModel>> createDepartment(
      DepartmentModel model);
  Future<Either<Failure, DepartmentModel>> updateDepartment(
      DepartmentModel model);
  Future<Either<Failure, bool>> deleteDepartment(String id);
}
