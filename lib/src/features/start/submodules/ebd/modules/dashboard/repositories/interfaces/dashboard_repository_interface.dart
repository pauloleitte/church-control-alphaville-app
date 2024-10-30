import '../../models/lighthouse_report_model.dart';

import '../../models/daily_report_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../../shared/errors/errors.dart';

abstract class IDashBoardRepository implements Disposable {
  Future<Either<Failure, List<DailyReport>>> getDailyReport(String date);
  Future<Either<Failure, List<LightHouseReport>>> getLightHouseReport(String date);
}
