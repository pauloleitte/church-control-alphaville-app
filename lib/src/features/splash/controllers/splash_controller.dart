import 'dart:async';

import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/auth/services/interfaces/token_service_interface.dart';
import '../../../core/auth/services/interfaces/user_service_interface.dart';

part 'splash_controller.g.dart';

// ignore: library_private_types_in_public_api
class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  @observable
  bool busy = false;

  @observable
  bool isVisible = false;

  final IUserService userService;
  final ITokenService tokenService;

  _SplashControllerBase(this.userService, this.tokenService);

  Future<void> init() async {
    var user = await userService.getCurrentUser();
    var token = await tokenService.getCurrentToken();
    if (user.name != null && token.accessToken != null) {
      Modular.to.navigate(AppRoutes.HOME);
    } else {
      Modular.to.navigate(AppRoutes.AUTH);
    }
  }
}
