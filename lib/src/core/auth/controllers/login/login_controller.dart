import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../config/app_routes.dart';
import '../../services/token_service.dart';
import '../../services/user_service.dart';
import '../../view-models/login_view_model.dart';

part 'login_controller.g.dart';

// ignore: library_private_types_in_public_api
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  String? email;

  @observable
  String? password;

  @observable
  bool busy = false;

  @observable
  bool isError = false;

  @observable
  String userEmailSession = "";

  final UserService _userService;

  final TokenService _tokenService;

  _LoginControllerBase(this._userService, this._tokenService);

  @computed
  LoginViewModel get model => LoginViewModel(email: email, password: password);

  @computed
  String get userEmailSessionVM => userEmailSession;

  Future<void> login() async {
    try {
      busy = true;
      isError = false;
      var result = await _userService.login(model);
      result.fold((failure) {
        isError = true;
        _userService.removeUserFromSharedPreferences();
        _tokenService.removeTokenFromSharedPreferences();
      }, (token) async {
        _tokenService.saveTokenLocal(token);
        Modular.to.navigate(AppRoutes.HOME);
      });
    } catch (e) {
      isError = true;
    } finally {
      busy = false;
    }
  }

  Future<void> getUserEmailSession() async {
    try {
      userEmailSession = await _userService.getUserEmail();
    } catch (e) {
      e.toString();
    }
  }

  Future<void> clearSession() async {
    try {
      await _userService.removeUserFromSharedPreferences();
      await _tokenService.removeTokenFromSharedPreferences();
    } catch (e) {
      e.toString();
    }
  }
}
