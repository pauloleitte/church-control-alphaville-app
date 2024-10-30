import 'package:dartz/dartz.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:church_control/src/shared/errors/errors.dart';
import '../../student/models/student_model.dart';
import '../../group/view-models/group_view_model.dart';
import '../../group/models/group_model.dart';
import '../../../../../../../core/auth/models/user_model.dart';
import '../repositories/interfaces/group_repository_interface.dart';
import 'interfaces/group_service_interface.dart';

class GroupService implements IGroupService {
  final IGroupRepository _groupRepository;
  GroupService(this._groupRepository);

  @override
  Future<Either<Failure, GroupModel>> createGroup(GroupViewModel model) {
    return _groupRepository.createGroup(GroupModel(
      name: model.name,
      description: model.description,
      teachers: model.teachers,
      secretaries: model.secretaries,
      students: model.students,
    ));
  }

  @override
  Future<Either<Failure, bool>> deleteGroup(GroupViewModel model) {
    return _groupRepository.deleteGroup(model.sId.toString());
  }

  @override
  Future<Either<Failure, GroupModel>> getGroup(GroupViewModel model) {
    return _groupRepository.getGroup(model.sId.toString());
  }

  @override
  Future<Either<Failure, ResponseGroups>> getGroups(FilterOptions options) {
    return _groupRepository.getGroups(options);
  }

  @override
  Future<Either<Failure, List<UserModel>>> getSecretaries(String id) {
    return _groupRepository.getSecretariesByGroupId(id);
  }

  @override
  Future<Either<Failure, List<StudentModel>>> getStudents(String id) {
    return _groupRepository.getStudentsByGroupId(id);
  }

  @override
  Future<Either<Failure, List<UserModel>>> getTeachers(String id) {
    return _groupRepository.getTeachersByGroupId(id);
  }

  @override
  Future<Either<Failure, bool>> updateGroup(GroupViewModel model) {
    return _groupRepository.updateGroup(GroupModel(
      sId: model.sId,
      name: model.name,
      description: model.description,
      teachers: model.teachers,
      secretaries: model.secretaries,
      students: model.students,
    ));
  }

  @override
  Future<Either<Failure, List<GroupModel>>> getGroupsByUserId(String id) async {
    return _groupRepository.getGroupsByUserId(id);
  }

  @override
  void dispose() {}
}
