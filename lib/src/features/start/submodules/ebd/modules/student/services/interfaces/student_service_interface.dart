import 'package:church_control/src/shared/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';


import '../../../../../../../../shared/utils/filter_options.dart';
import '../../models/student_model.dart';
import '../../view-models/student_view_model.dart';

abstract class IStudentService implements Disposable {
  Future<Either<Failure, ResponseStudents>> getStudents(FilterOptions options);
  Future<Either<Failure, StudentModel>> getStudent(StudentViewModel model);
  Future<Either<Failure, bool>> createStudent(StudentViewModel model);
  Future<Either<Failure, bool>> updateStudent(StudentViewModel model);
  Future<Either<Failure, bool>> deleteStudent(StudentViewModel model);
}
