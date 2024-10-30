import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';


import '../../../../../../../../shared/errors/errors.dart';
import '../../models/notice_model.dart';
import '../../view-model/notice_view_model.dart';

abstract class INoticeService extends Disposable {
  Future<Either<Failure, ResponseWeeksAgenda>> getWeeksAgenda();
  Future<Either<Failure, ResponseNotices>> getNotices(FilterOptions options);
  Future<Either<Failure, ResponseFindAllNotices>> findAll();
  Future<Either<Failure, NoticeModel>> getNotice(NoticeViewModel notice);
  Future<Either<Failure, NoticeModel>> createNotice(NoticeViewModel notice);
  Future<Either<Failure, NoticeModel>> updateNotice(NoticeViewModel notice);
  Future<Either<Failure, bool>> deleteNotice(NoticeViewModel notice);
}
