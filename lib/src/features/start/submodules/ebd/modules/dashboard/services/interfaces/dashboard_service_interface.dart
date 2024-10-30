import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../../shared/errors/errors.dart';
import '../../models/daily_report_model.dart';
import '../../models/lighthouse_report_model.dart';

abstract class IDashBoardService implements Disposable {
  Future<Either<Failure, List<DailyReport>>> getDailyReport(String date);
  Future<Either<Failure, List<LightHouseReport>>> getLightHouseReport(
      String date);

  String listDailyReportToCsv(List<DailyReport> data);
  String listLightHouseReportToCsv(List<LightHouseReport> data);
  Future<void> downloadDailyReport(String csvDailyReport);
  Future<void> downloadLightHouseReport(String csvLightHouseReport);
}
