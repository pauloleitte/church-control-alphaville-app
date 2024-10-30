import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/notice_model.dart';

abstract class INoticeRepository extends Disposable {
  Future<Either<Failure, ResponseWeeksAgenda>> getWeeksAgenda();
  Future<Either<Failure, ResponseNotices>> getNotices(FilterOptions options);
  Future<Either<Failure, ResponseFindAllNotices>> findAll();
  Future<Either<Failure, NoticeModel>> getNotice(String id);
  Future<Either<Failure, NoticeModel>> createNotice(NoticeModel notice);
  Future<Either<Failure, NoticeModel>> updateNotice(NoticeModel notice);
  Future<Either<Failure, bool>> deleteNotice(String id);
}
