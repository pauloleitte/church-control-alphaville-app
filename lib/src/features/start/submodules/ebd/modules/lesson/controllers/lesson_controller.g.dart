// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LessonController on _LessonControllerBase, Store {
  Computed<LessonViewModel>? _$modelComputed;

  @override
  LessonViewModel get model =>
      (_$modelComputed ??= Computed<LessonViewModel>(() => super.model,
              name: '_LessonControllerBase.model'))
          .value;

  late final _$lessonAtom =
      Atom(name: '_LessonControllerBase.lesson', context: context);

  @override
  LessonModel get lesson {
    _$lessonAtom.reportRead();
    return super.lesson;
  }

  @override
  set lesson(LessonModel value) {
    _$lessonAtom.reportWrite(value, super.lesson, () {
      super.lesson = value;
    });
  }

  late final _$lessonsAtom =
      Atom(name: '_LessonControllerBase.lessons', context: context);

  @override
  List<LessonModel> get lessons {
    _$lessonsAtom.reportRead();
    return super.lessons;
  }

  @override
  set lessons(List<LessonModel> value) {
    _$lessonsAtom.reportWrite(value, super.lessons, () {
      super.lessons = value;
    });
  }

  late final _$groupsAtom =
      Atom(name: '_LessonControllerBase.groups', context: context);

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

  late final _$groupsByUserAtom =
      Atom(name: '_LessonControllerBase.groupsByUser', context: context);

  @override
  List<GroupModel> get groupsByUser {
    _$groupsByUserAtom.reportRead();
    return super.groupsByUser;
  }

  @override
  set groupsByUser(List<GroupModel> value) {
    _$groupsByUserAtom.reportWrite(value, super.groupsByUser, () {
      super.groupsByUser = value;
    });
  }

  late final _$secretariesAtom =
      Atom(name: '_LessonControllerBase.secretaries', context: context);

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

  late final _$teachersAtom =
      Atom(name: '_LessonControllerBase.teachers', context: context);

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

  late final _$studentsAtom =
      Atom(name: '_LessonControllerBase.students', context: context);

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

  late final _$paginationAtom =
      Atom(name: '_LessonControllerBase.pagination', context: context);

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
      Atom(name: '_LessonControllerBase.busy', context: context);

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
lesson: ${lesson},
lessons: ${lessons},
groups: ${groups},
groupsByUser: ${groupsByUser},
secretaries: ${secretaries},
teachers: ${teachers},
students: ${students},
pagination: ${pagination},
busy: ${busy},
model: ${model}
    ''';
  }
}
