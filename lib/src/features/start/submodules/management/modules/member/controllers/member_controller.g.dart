// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MemberController on _MemberControllerBase, Store {
  Computed<MemberViewModel>? _$modelComputed;

  @override
  MemberViewModel get model =>
      (_$modelComputed ??= Computed<MemberViewModel>(() => super.model,
              name: '_MemberControllerBase.model'))
          .value;

  late final _$busyAtom =
      Atom(name: '_MemberControllerBase.busy', context: context);

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

  late final _$memberAtom =
      Atom(name: '_MemberControllerBase.member', context: context);

  @override
  MemberModel get member {
    _$memberAtom.reportRead();
    return super.member;
  }

  @override
  set member(MemberModel value) {
    _$memberAtom.reportWrite(value, super.member, () {
      super.member = value;
    });
  }

  late final _$paginationAtom =
      Atom(name: '_MemberControllerBase.pagination', context: context);

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

  late final _$membersAtom =
      Atom(name: '_MemberControllerBase.members', context: context);

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

  @override
  String toString() {
    return '''
busy: ${busy},
member: ${member},
pagination: ${pagination},
members: ${members},
model: ${model}
    ''';
  }
}
