import 'dart:convert';

import 'package:church_control/src/core/config/app_constants.dart';

import '../../../shared/services/local_storage_service.dart';
import './interfaces/token_service_interface.dart';
import '../models/token_model.dart';

class TokenService implements ITokenService {
  TokenService();

  @override
  void dispose() {}

  @override
  Future<TokenModel> getCurrentToken() async {
    var contains = await LocalStorageService.contains(AppConstants.TOKEN_KEY);
    if (contains) {
      var res = jsonDecode(
          await LocalStorageService.getValue<String>(AppConstants.TOKEN_KEY));
      return TokenModel.fromJson(res);
    } else {
      return TokenModel();
    }
  }

  @override
  Future<void> saveTokenLocal(TokenModel model) async {
    LocalStorageService.setValue<String>(
        AppConstants.TOKEN_KEY, jsonEncode(model.toJson()));
  }

  @override
  Future<void> removeTokenFromSharedPreferences() async {
    await LocalStorageService.remove(AppConstants.TOKEN_KEY);
  }
}
