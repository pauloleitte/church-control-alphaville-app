import 'package:mobx/mobx.dart';

import '../models/token_model.dart';
import '../services/interfaces/token_service_interface.dart';

part 'token_store.g.dart';

// ignore: library_private_types_in_public_api
class TokenStore = _TokenStoreBase with _$TokenStore;

abstract class _TokenStoreBase with Store {
  final ITokenService _tokenService;

  @observable
  late TokenModel model = TokenModel();

  _TokenStoreBase(this._tokenService);

  @action
  void setToken(TokenModel v) {
    model = v;
    _tokenService.saveTokenLocal(v);
  }

  @action
  void clearToken() {
    model = TokenModel();
    _tokenService.saveTokenLocal(model);
  }
}
