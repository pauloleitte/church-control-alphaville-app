import 'package:dartz/dartz.dart';

import '../../../../../../../shared/errors/errors.dart';
import '../../../../../../../shared/utils/filter_options.dart';
import '../models/lesson_model.dart';
import '../reposotories/interfaces/lesson_repositoy_interface.dart';
import '../view-models/lesson_view_model.dart';
import 'interfaces/lesson_service_interface.dart';

class LessonService implements ILessonService {
  final ILessonRepository _lessonRepository;
  LessonService(this._lessonRepository);

  @override
  Future<Either<Failure, bool>> createLesson(LessonViewModel model) {
    return _lessonRepository.createLesson(LessonModel(
      name: model.name,
      description: model.description,
      offerValue:  model.offerValue,
      attendance: model.attendance,
      group: model.group,
      date: model.date,
      teacher: model.teacher,
      secretary: model.secretary,
    ));
  }

  @override
  Future<Either<Failure, bool>> deleteLesson(LessonViewModel model) {
    return _lessonRepository.deleteLesson(model.sId.toString());
  }

  @override
  Future<Either<Failure, LessonModel>> getLesson(LessonViewModel model) {
    return _lessonRepository.getLesson(model.sId.toString());
  }

  @override
  Future<Either<Failure, ResponseLessons>> getLessons(FilterOptions options) {
    return _lessonRepository.getLessons(options);
  }

  @override
  Future<Either<Failure, ResponseLessons>> getLessonsByGroupId(
      FilterOptions options) {
    return _lessonRepository.getLessonsByGroupId(options);
  }

  @override
  void dispose() {}

  @override
  Future<Either<Failure, bool>> updateLesson(LessonViewModel model) {
    return _lessonRepository.updateLesson(LessonModel(
      sId: model.sId,
      name: model.name,
      description: model.description,
      offerValue: model.offerValue,
      attendance: model.attendance,
      group: model.group,
      date: model.date,
      teacher: model.teacher,
      secretary: model.secretary,
    ));
  }
}
