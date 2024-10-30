import 'package:flutter_modular/flutter_modular.dart';

import '../../models/token_model.dart';

abstract class ITokenService implements Disposable {
  Future<TokenModel> getCurrentToken();
  Future<void> removeTokenFromSharedPreferences();
  Future<void> saveTokenLocal(TokenModel model);
}
