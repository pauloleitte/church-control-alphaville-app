import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../lesson/models/lesson_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../../../shared/errors/errors.dart';

abstract class ILessonRepository implements Disposable {
  Future<Either<Failure, ResponseLessons>> getLessons(FilterOptions options);
  Future<Either<Failure, LessonModel>> getLesson(String id);
  Future<Either<Failure, bool>> createLesson(LessonModel lesson);
  Future<Either<Failure, bool>> updateLesson(LessonModel lesson);
  Future<Either<Failure, bool>> deleteLesson(String id);
  Future<Either<Failure, ResponseLessons>> getLessonsByGroupId(FilterOptions options);
}
