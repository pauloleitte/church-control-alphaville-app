// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TokenStore on _TokenStoreBase, Store {
  late final _$modelAtom =
      Atom(name: '_TokenStoreBase.model', context: context);

  @override
  TokenModel get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  bool _modelIsInitialized = false;

  @override
  set model(TokenModel value) {
    _$modelAtom.reportWrite(value, _modelIsInitialized ? super.model : null,
        () {
      super.model = value;
      _modelIsInitialized = true;
    });
  }

  late final _$_TokenStoreBaseActionController =
      ActionController(name: '_TokenStoreBase', context: context);

  @override
  void setToken(TokenModel v) {
    final _$actionInfo = _$_TokenStoreBaseActionController.startAction(
        name: '_TokenStoreBase.setToken');
    try {
      return super.setToken(v);
    } finally {
      _$_TokenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearToken() {
    final _$actionInfo = _$_TokenStoreBaseActionController.startAction(
        name: '_TokenStoreBase.clearToken');
    try {
      return super.clearToken();
    } finally {
      _$_TokenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
model: ${model}
    ''';
  }
}
