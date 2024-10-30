import '../../../../../../../../core/auth/models/user_model.dart';
import '../../../student/models/student_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../../shared/errors/errors.dart';
import '../../../../../../../../shared/utils/filter_options.dart';
import '../../models/group_model.dart';
import '../../view-models/group_view_model.dart';

abstract class IGroupService implements Disposable {
  Future<Either<Failure, ResponseGroups>> getGroups(FilterOptions options);
  Future<Either<Failure, GroupModel>> getGroup(GroupViewModel model);
  Future<Either<Failure, GroupModel>> createGroup(GroupViewModel model);
  Future<Either<Failure, bool>> updateGroup(GroupViewModel model);
  Future<Either<Failure, bool>> deleteGroup(GroupViewModel model);
  Future<Either<Failure, List<UserModel>>> getTeachers(String id);
  Future<Either<Failure, List<UserModel>>> getSecretaries(String id);
  Future<Either<Failure, List<StudentModel>>> getStudents(String id);
  Future<Either<Failure, List<GroupModel>>> getGroupsByUserId(String id);
}
