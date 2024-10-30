import '../../../../../../../../core/auth/models/user_model.dart';
import '../../../student/models/student_model.dart';
import '../../../../../../../../shared/errors/errors.dart';
import '../../../../../../../../shared/utils/filter_options.dart';
import '../../models/group_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';



abstract class IGroupRepository implements Disposable {
  Future<Either<Failure, ResponseGroups>> getGroups(FilterOptions options);
  Future<Either<Failure, GroupModel>> getGroup(String id);
  Future<Either<Failure, GroupModel>> createGroup(GroupModel model);
  Future<Either<Failure, bool>> updateGroup(GroupModel model);
  Future<Either<Failure, bool>> deleteGroup(String id);
  Future<Either<Failure, List<GroupModel>>> getGroupsByUserId(String id);
  Future<Either<Failure, List<UserModel>>> getTeachersByGroupId(String id);
  Future<Either<Failure, List<UserModel>>> getSecretariesByGroupId(String id);
  Future<Either<Failure, List<StudentModel>>> getStudentsByGroupId(String id);
}
