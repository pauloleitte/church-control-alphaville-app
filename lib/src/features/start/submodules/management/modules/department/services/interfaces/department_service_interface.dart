import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/department_model.dart';
import '../../view-models/department_view_model.dart';

abstract class IDepartmentService implements Disposable {
  Future<Either<Failure, ResponseDepartments>> getDepartments(
      FilterOptions options);
  Future<Either<Failure, DepartmentModel>> getDepartment(
      DepartmentViewModel model);
  Future<Either<Failure, DepartmentModel>> createDepartment(
      DepartmentViewModel model);
  Future<Either<Failure, DepartmentModel>> updateDepartment(
      DepartmentViewModel model);
  Future<Either<Failure, bool>> deleteDepartment(DepartmentViewModel model);
}
