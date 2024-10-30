import 'package:church_control/src/shared/errors/errors.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../../shared/utils/filter_options.dart';
import '../models/student_model.dart';
import '../repositories/interfaces/student_repository_interface.dart';
import '../view-models/student_view_model.dart';
import 'interfaces/student_service_interface.dart';

class StudentService implements IStudentService {
  final IStudentRepository _studentRepository;
  StudentService(this._studentRepository);

  @override
  Future<Either<Failure, bool>> createStudent(
      StudentViewModel model) async {
    return await _studentRepository.createStudent(StudentModel(
      name: model.name,
      phone: model.phone,
      email: model.email,
      group: model.group,
    ));
  }

  @override
  Future<Either<Failure, ResponseStudents>> getStudents(
          FilterOptions options) async =>
      await _studentRepository.getStudents(options);

  @override
  Future<Either<Failure, StudentModel>> getStudent(
          StudentViewModel model) async =>
      await _studentRepository.getStudent(model.id.toString());

  @override
  Future<Either<Failure, bool>> updateStudent(
      StudentViewModel model) async {
    return await _studentRepository.updateStudent(StudentModel(
      sId: model.id,
      name: model.name,
      phone: model.phone,
      email: model.email,
      group: model.group,
    ));
  }

  @override
  Future<Either<Failure, bool>> deleteStudent(StudentViewModel model) {
    return _studentRepository.deleteStudent(model.id.toString());
  }

  @override
  void dispose() {}
}
