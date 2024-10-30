import 'package:mobx/mobx.dart';


import '../../../../../../core/auth/models/user_model.dart';
import '../../../../../../core/auth/services/interfaces/token_service_interface.dart';
import '../../../../../../core/auth/services/interfaces/user_service_interface.dart';
import '../../../../store/start_store.dart';

part 'configuration_controller.g.dart';

// ignore: library_private_types_in_public_api
class ConfigurationController = _ConfigurationControllerBase
    with _$ConfigurationController;

abstract class _ConfigurationControllerBase with Store {
  @observable
  UserModel model = UserModel();

  @observable
  bool busy = false;

  final IUserService _userService;
  final ITokenService _tokenService;
  final StartStore store;

  _ConfigurationControllerBase(
      this._userService, this._tokenService, this.store);

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

  logout() async {
    await _userService.removeUserFromSharedPreferences();
    await _tokenService.removeTokenFromSharedPreferences();
  }
}
