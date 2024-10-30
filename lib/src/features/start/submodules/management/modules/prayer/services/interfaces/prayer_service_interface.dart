import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../../../shared/errors/errors.dart';
import '../../../../../../../../shared/utils/filter_options.dart';
import '../../models/prayer_model.dart';
import '../../view-model/prayer_view_model.dart';

abstract class IPrayerService extends Disposable {
  Future<Either<Failure, ResponsePrayers>> getPrayers(FilterOptions options);
  Future<Either<Failure, ResponseFindAllPrayers>> findAll();
  Future<Either<Failure, PrayerModel>> getPrayer(PrayerViewModel notice);
  Future<Either<Failure, PrayerModel>> createPrayer(PrayerViewModel notice);
  Future<Either<Failure, PrayerModel>> updatePrayer(PrayerViewModel notice);
  Future<Either<Failure, bool>> deletePrayer(PrayerViewModel notice);
}
