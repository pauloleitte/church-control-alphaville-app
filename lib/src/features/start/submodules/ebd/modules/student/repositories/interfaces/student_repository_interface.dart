import '../../../../../../../../shared/utils/filter_options.dart';
import '../../models/student_model.dart';
import 'package:church_control/src/shared/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class IStudentRepository implements Disposable {
  Future<Either<Failure, ResponseStudents>> getStudents(FilterOptions options);
  Future<Either<Failure, StudentModel>> getStudent(String id);
  Future<Either<Failure, bool>> createStudent(StudentModel model);
  Future<Either<Failure, bool>> updateStudent(StudentModel model);
  Future<Either<Failure, bool>> deleteStudent(String id);
}
