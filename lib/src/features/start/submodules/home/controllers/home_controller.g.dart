// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$modelAtom =
      Atom(name: '_HomeControllerBase.model', context: context);

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

  late final _$ceremoniesAtom =
      Atom(name: '_HomeControllerBase.ceremonies', context: context);

  @override
  List<CeremonyModel> get ceremonies {
    _$ceremoniesAtom.reportRead();
    return super.ceremonies;
  }

  @override
  set ceremonies(List<CeremonyModel> value) {
    _$ceremoniesAtom.reportWrite(value, super.ceremonies, () {
      super.ceremonies = value;
    });
  }

  late final _$membersAtom =
      Atom(name: '_HomeControllerBase.members', context: context);

  @override
  List<MemberModel> get members {
    _$membersAtom.reportRead();
    return super.members;
  }

  @override
  set members(List<MemberModel> value) {
    _$membersAtom.reportWrite(value, super.members, () {
      super.members = value;
    });
  }

  late final _$noticesAtom =
      Atom(name: '_HomeControllerBase.notices', context: context);

  @override
  List<NoticeModel> get notices {
    _$noticesAtom.reportRead();
    return super.notices;
  }

  @override
  set notices(List<NoticeModel> value) {
    _$noticesAtom.reportWrite(value, super.notices, () {
      super.notices = value;
    });
  }

  late final _$busyAtom =
      Atom(name: '_HomeControllerBase.busy', context: context);

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
ceremonies: ${ceremonies},
members: ${members},
notices: ${notices},
busy: ${busy}
    ''';
  }
}
