import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';

import '../models/department_model.dart';
import '../repositories/interfaces/department_repository_interface.dart';
import '../view-models/department_view_model.dart';
import 'interfaces/department_service_interface.dart';

class DepartmentService implements IDepartmentService  {
  final IDepartmentRepository _departmentRepository;
  DepartmentService(this._departmentRepository);

  @override
  Future<Either<Failure, DepartmentModel>> createDepartment(
      DepartmentViewModel model) async {
    return await _departmentRepository.createDepartment(DepartmentModel(
        name: model.name,
        description: model.description,
        notices: model.notices,
        members: model.members));
  }

  @override
  Future<Either<Failure, ResponseDepartments>> getDepartments(
          FilterOptions options) async =>
      await _departmentRepository.getDepartments(options);

  @override
  Future<Either<Failure, DepartmentModel>> getDepartment(
          DepartmentViewModel model) async =>
      await _departmentRepository.getDepartment(model.id.toString());

  @override
  Future<Either<Failure, DepartmentModel>> updateDepartment(
      DepartmentViewModel model) async {
    return await _departmentRepository.updateDepartment(DepartmentModel(
        sId: model.id,
        name: model.name,
        members: model.members,
        notices: model.notices,
        description: model.description));
  }

  @override
  Future<Either<Failure, bool>> deleteDepartment(DepartmentViewModel model) {
    return _departmentRepository.deleteDepartment(model.id.toString());
  }

  @override
  void dispose() {}
}