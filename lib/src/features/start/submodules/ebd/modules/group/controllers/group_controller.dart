import 'package:church_control/src/core/auth/models/user_model.dart';
import 'package:church_control/src/core/auth/services/interfaces/user_service_interface.dart';
import '../../group/services/interfaces/group_service_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../shared/utils/filter_options.dart';
import '../../../../../../../shared/utils/pagination_model.dart';
import '../models/group_model.dart';
import '../view-models/group_view_model.dart';

part 'group_controller.g.dart';

// ignore: library_private_types_in_public_api
class GroupController = _GroupControllerBase with _$GroupController;

abstract class _GroupControllerBase with Store {
  @observable
  GroupModel group = GroupModel();

  @observable
  List<GroupModel> groups = [];

  @observable
  List<UserModel> teachers = [];

  @observable
  List<UserModel> secretaries = [];

  @observable
  PaginationModel pagination = PaginationModel();

  @observable
  bool busy = false;

  final IGroupService groupService;

  final IUserService userService;

  _GroupControllerBase(this.groupService, this.userService);

  @computed
  GroupViewModel get model => GroupViewModel(
        sId: group.sId,
        name: group.name,
        description: group.description,
        students: group.students,
        teachers: group.teachers,
        secretaries: group.secretaries,
        lessons: group.lessons,
      );

  Future<void> getTeachers() async {
    try {
      var result = await userService.getUsersByRole('teacher');
      result.fold((l) {
        busy = false;
      }, (response) async {
        teachers = response;
      });
    } catch (e) {
      busy = false;
    }
  }

  Future<void> getSecretaries() async {
    try {
      var result = await userService.getUsersByRole('secretary');
      result.fold((l) {
        busy = false;
      }, (response) async {
        secretaries = response;
      });
    } catch (e) {
      busy = false;
    }
  }

  Future<void> getGroups(FilterOptions options) async {
    try {
      if (options.page != null) {
        if (options.page == 1) busy = true;
      }
      var result = await groupService.getGroups(options);
      result.fold((l) {
        busy = false;
      }, (response) async {
        pagination = response.pagination;
        groups = response.groups;
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> deleteGroup() async {
    try {
      busy = true;
      var result = await groupService.deleteGroup(model);
      result.fold((l) {}, (_) async {
        Modular.to.navigate(AppRoutes.GROUP);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> updateGroup() async {
    try {
      busy = true;
      var result = await groupService.updateGroup(model);
      result.fold((l) {
        busy = false;
      }, (_) async {
        Modular.to.navigate(AppRoutes.GROUP);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> createGroup() async {
    try {
      busy = true;
      var result = await groupService.createGroup(model);
      result.fold((l) {}, (_) async {
        Modular.to.navigate(AppRoutes.GROUP);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }
}
