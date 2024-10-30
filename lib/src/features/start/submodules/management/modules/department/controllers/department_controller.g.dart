// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DepartmentController on _DepartmentControllerBase, Store {
  Computed<DepartmentViewModel>? _$modelComputed;

  @override
  DepartmentViewModel get model =>
      (_$modelComputed ??= Computed<DepartmentViewModel>(() => super.model,
              name: '_DepartmentControllerBase.model'))
          .value;

  late final _$departmentAtom =
      Atom(name: '_DepartmentControllerBase.department', context: context);

  @override
  DepartmentModel get department {
    _$departmentAtom.reportRead();
    return super.department;
  }

  @override
  set department(DepartmentModel value) {
    _$departmentAtom.reportWrite(value, super.department, () {
      super.department = value;
    });
  }

  late final _$paginationAtom =
      Atom(name: '_DepartmentControllerBase.pagination', context: context);

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
      Atom(name: '_DepartmentControllerBase.members', context: context);

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
      Atom(name: '_DepartmentControllerBase.notices', context: context);

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
      Atom(name: '_DepartmentControllerBase.busy', context: context);

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

  late final _$departmentsAtom =
      Atom(name: '_DepartmentControllerBase.departments', context: context);

  @override
  List<DepartmentModel> get departments {
    _$departmentsAtom.reportRead();
    return super.departments;
  }

  @override
  set departments(List<DepartmentModel> value) {
    _$departmentsAtom.reportWrite(value, super.departments, () {
      super.departments = value;
    });
  }

  @override
  String toString() {
    return '''
department: ${department},
pagination: ${pagination},
members: ${members},
notices: ${notices},
busy: ${busy},
departments: ${departments},
model: ${model}
    ''';
  }
}
