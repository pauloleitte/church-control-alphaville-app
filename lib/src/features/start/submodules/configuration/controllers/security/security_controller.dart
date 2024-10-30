
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../core/auth/models/user_model.dart';
import '../../../../../../core/auth/services/interfaces/user_service_interface.dart';
import '../../../../../../core/config/app_routes.dart';
import '../../view-models/user_view_model.dart';



part 'security_controller.g.dart';

// ignore: library_private_types_in_public_api
class SecurityController = _SecurityControllerBase with _$SecurityController;

abstract class _SecurityControllerBase with Store {
  @observable
  UserModel model = UserModel();

  @observable
  bool busy = false;

  @computed
  UserViewModel get vm => UserViewModel(
      id: model.sId,
      password: model.password,
      genre: model.genre,
      roles: model.roles,
      tokens: model.tokens,
      avatarUrl: model.avatarUrl,
      email: model.email,
      name: model.name,
      phone: model.phone);

  final IUserService _userService;

  _SecurityControllerBase(this._userService);

  updatePassword() async {
    try {
      busy = true;
      var result = await _userService.updatePassword(vm);
      result.fold((l) {
        
      }, (user) {
        
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
      var result = await _userService.getCurrentUser();
      model = result;
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }
}
