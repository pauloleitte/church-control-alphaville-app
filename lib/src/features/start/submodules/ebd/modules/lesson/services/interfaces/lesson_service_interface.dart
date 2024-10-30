import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../../../shared/errors/errors.dart';
import '../../../../../../../../shared/utils/filter_options.dart';
import '../../models/lesson_model.dart';
import '../../view-models/lesson_view_model.dart';

abstract class ILessonService implements Disposable {
  Future<Either<Failure, ResponseLessons>> getLessons(FilterOptions options);
  Future<Either<Failure, LessonModel>> getLesson(LessonViewModel model);
  Future<Either<Failure, bool>> createLesson(LessonViewModel model);
  Future<Either<Failure, bool>> updateLesson(LessonViewModel model);
  Future<Either<Failure, bool>> deleteLesson(LessonViewModel model);
  Future<Either<Failure, ResponseLessons>> getLessonsByGroupId(FilterOptions options);
}
