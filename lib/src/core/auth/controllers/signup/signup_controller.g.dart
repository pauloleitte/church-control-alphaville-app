// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignupController on _SignupControllerBase, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_SignupControllerBase.isValid'))
      .value;
  Computed<bool>? _$isValidEmailComputed;

  @override
  bool get isValidEmail =>
      (_$isValidEmailComputed ??= Computed<bool>(() => super.isValidEmail,
              name: '_SignupControllerBase.isValidEmail'))
          .value;
  Computed<SignupViewModel>? _$vmComputed;

  @override
  SignupViewModel get vm =>
      (_$vmComputed ??= Computed<SignupViewModel>(() => super.vm,
              name: '_SignupControllerBase.vm'))
          .value;

  late final _$modelAtom =
      Atom(name: '_SignupControllerBase.model', context: context);

  @override
  UserModel get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(UserModel value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  late final _$busyAtom =
      Atom(name: '_SignupControllerBase.busy', context: context);

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

  @override
  String toString() {
    return '''
model: ${model},
busy: ${busy},
isValid: ${isValid},
isValidEmail: ${isValidEmail},
vm: ${vm}
    ''';
  }
}
