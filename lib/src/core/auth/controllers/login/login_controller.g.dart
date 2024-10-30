// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<LoginViewModel>? _$modelComputed;

  @override
  LoginViewModel get model =>
      (_$modelComputed ??= Computed<LoginViewModel>(() => super.model,
              name: '_LoginControllerBase.model'))
          .value;
  Computed<String>? _$userEmailSessionVMComputed;

  @override
  String get userEmailSessionVM => (_$userEmailSessionVMComputed ??=
          Computed<String>(() => super.userEmailSessionVM,
              name: '_LoginControllerBase.userEmailSessionVM'))
      .value;

  late final _$emailAtom =
      Atom(name: '_LoginControllerBase.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_LoginControllerBase.password', context: context);

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$busyAtom =
      Atom(name: '_LoginControllerBase.busy', context: context);

  @override
  bool get busy {
    _$busyAtom.reportRead();
    return super.busy;
  }

  @override
  set busy(bool value) {
    _$busyAtom.reportWrite(value, super.busy, () {
      super.busy = value;
    });
  }

  late final _$isErrorAtom =
      Atom(name: '_LoginControllerBase.isError', context: context);

  @override
  bool get isError {
    _$isErrorAtom.reportRead();
    return super.isError;
  }

  @override
  set isError(bool value) {
    _$isErrorAtom.reportWrite(value, super.isError, () {
      super.isError = value;
    });
  }

  late final _$userEmailSessionAtom =
      Atom(name: '_LoginControllerBase.userEmailSession', context: context);

  @override
  String get userEmailSession {
    _$userEmailSessionAtom.reportRead();
    return super.userEmailSession;
  }

  @override
  set userEmailSession(String value) {
    _$userEmailSessionAtom.reportWrite(value, super.userEmailSession, () {
      super.userEmailSession = value;
    });
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
busy: ${busy},
isError: ${isError},
userEmailSession: ${userEmailSession},
model: ${model},
userEmailSessionVM: ${userEmailSessionVM}
    ''';
  }
}
