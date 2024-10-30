// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StudentController on _StudentControllerBase, Store {
  Computed<StudentViewModel>? _$modelComputed;

  @override
  StudentViewModel get model =>
      (_$modelComputed ??= Computed<StudentViewModel>(() => super.model,
              name: '_StudentControllerBase.model'))
          .value;

  late final _$studentAtom =
      Atom(name: '_StudentControllerBase.student', context: context);

  @override
  StudentModel get student {
    _$studentAtom.reportRead();
    return super.student;
  }

  @override
  set student(StudentModel value) {
    _$studentAtom.reportWrite(value, super.student, () {
      super.student = value;
    });
  }

  late final _$paginationAtom =
      Atom(name: '_StudentControllerBase.pagination', context: context);

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
      Atom(name: '_StudentControllerBase.busy', context: context);

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

  late final _$studentsAtom =
      Atom(name: '_StudentControllerBase.students', context: context);

  @override
  List<StudentModel> get students {
    _$studentsAtom.reportRead();
    return super.students;
  }

  @override
  set students(List<StudentModel> value) {
    _$studentsAtom.reportWrite(value, super.students, () {
      super.students = value;
    });
  }

  late final _$groupsAtom =
      Atom(name: '_StudentControllerBase.groups', context: context);

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

  @override
  String toString() {
    return '''
student: ${student},
pagination: ${pagination},
busy: ${busy},
students: ${students},
groups: ${groups},
model: ${model}
    ''';
  }
}
