import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../core/auth/models/user_model.dart';
import '../../../../../../core/auth/services/interfaces/user_service_interface.dart';
import '../../view-models/user_view_model.dart';

part 'profile_controller.g.dart';

// ignore: library_private_types_in_public_api
class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  @observable
  UserModel model = UserModel();

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

  _ProfileControllerBase(this._userService);

  updateUser() async {
    try {
      busy = true;
      var result = await _userService.updateUser(vm);
      result.fold((l) {}, (user) async {
        await _userService.saveUserLocal(user);

        Modular.to.navigate(AppRoutes.CONFIG);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  getUser() async {
    try {
      busy = true;
      var result = await _userService.getUser();
      result.fold((l) {}, (user) {
        model = user;
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }
}
