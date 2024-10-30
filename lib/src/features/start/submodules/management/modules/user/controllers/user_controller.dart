import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:church_control/src/shared/utils/pagination_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../core/auth/models/user_model.dart';
import '../../../../../../../core/auth/services/interfaces/user_service_interface.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../../../../configuration/view-models/user_view_model.dart';

part 'user_controller.g.dart';

// ignore: library_private_types_in_public_api
class UserController = _UserControllerBase with _$UserController;

abstract class _UserControllerBase with Store {
  @observable
  UserModel model = UserModel();

  @observable
  List<UserModel> users = [];

  @observable
  PaginationModel pagination = PaginationModel();

  @computed
  UserViewModel get vm => UserViewModel(
      id: model.sId,
      name: model.name,
      email: model.email,
      phone: model.phone,
      tokens: model.tokens,
      roles: model.roles,
      avatarUrl: model.avatarUrl,
      genre: model.genre);

  @observable
  bool busy = false;

  final IUserService _userService;

  _UserControllerBase(this._userService);

  createUser() async {
    try {
      busy = true;
      var result = await _userService.createUser(vm);
      result.fold((l) {}, (resp) async {
        Modular.to.navigate(AppRoutes.USER);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  updateUser() async {
    try {
      busy = true;
      var result = await _userService.updateUser(vm);
      result.fold((l) {}, (user) async {
        final currentUser = await _userService.getCurrentUser();
        if (currentUser.sId == user.sId) {
          await _userService.saveUserLocal(user);
        }
        Modular.to.navigate(AppRoutes.USER);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  deleteUser() async {
    try {
      busy = true;
      var result = await _userService.deleteUser(vm);
      result.fold((l) {}, (resp) async {
        Modular.to.pushReplacementNamed(AppRoutes.USER);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  getUsers(FilterOptions options) async {
    try {
      busy = true;
      var result = await _userService.getUsers(options);
      result.fold((l) {}, (resp) {
        pagination = resp.pagination;
        users = resp.users;
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }
}
