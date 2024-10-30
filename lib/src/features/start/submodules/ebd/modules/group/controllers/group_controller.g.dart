// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GroupController on _GroupControllerBase, Store {
  Computed<GroupViewModel>? _$modelComputed;

  @override
  GroupViewModel get model =>
      (_$modelComputed ??= Computed<GroupViewModel>(() => super.model,
              name: '_GroupControllerBase.model'))
          .value;

  late final _$groupAtom =
      Atom(name: '_GroupControllerBase.group', context: context);

  @override
  GroupModel get group {
    _$groupAtom.reportRead();
    return super.group;
  }

  @override
  set group(GroupModel value) {
    _$groupAtom.reportWrite(value, super.group, () {
      super.group = value;
    });
  }

  late final _$groupsAtom =
      Atom(name: '_GroupControllerBase.groups', context: context);

  @override
  List<GroupModel> get groups {
    _$groupsAtom.reportRead();
    return super.groups;
  }

  @override
  set groups(List<GroupModel> value) {
    _$groupsAtom.reportWrite(value, super.groups, () {
      super.groups = value;
    });
  }

  late final _$teachersAtom =
      Atom(name: '_GroupControllerBase.teachers', context: context);

  @override
  List<UserModel> get teachers {
    _$teachersAtom.reportRead();
    return super.teachers;
  }

  @override
  set teachers(List<UserModel> value) {
    _$teachersAtom.reportWrite(value, super.teachers, () {
      super.teachers = value;
    });
  }

  late final _$secretariesAtom =
      Atom(name: '_GroupControllerBase.secretaries', context: context);

  @override
  List<UserModel> get secretaries {
    _$secretariesAtom.reportRead();
    return super.secretaries;
  }

  @override
  set secretaries(List<UserModel> value) {
    _$secretariesAtom.reportWrite(value, super.secretaries, () {
      super.secretaries = value;
    });
  }

  late final _$paginationAtom =
      Atom(name: '_GroupControllerBase.pagination', context: context);

  @override
  PaginationModel get pagination {
    _$paginationAtom.reportRead();
    return super.pagination;
  }

  @override
  set pagination(PaginationModel value) {
    _$paginationAtom.reportWrite(value, super.pagination, () {
      super.pagination = value;
    });
  }

  late final _$busyAtom =
      Atom(name: '_GroupControllerBase.busy', context: context);

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
group: ${group},
groups: ${groups},
teachers: ${teachers},
secretaries: ${secretaries},
pagination: ${pagination},
busy: ${busy},
model: ${model}
    ''';
  }
}
