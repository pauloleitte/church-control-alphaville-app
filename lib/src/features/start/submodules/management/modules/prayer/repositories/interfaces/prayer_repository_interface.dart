// ignore_for_file: file_names

import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/prayer_model.dart';

abstract class IPrayerRepository extends Disposable {
  Future<Either<Failure, ResponsePrayers>> getPrayers(FilterOptions options);
  Future<Either<Failure, ResponseFindAllPrayers>> findAll();
  Future<Either<Failure, PrayerModel>> getPrayer(String id);
  Future<Either<Failure, PrayerModel>> createPrayer(PrayerModel prayer);
  Future<Either<Failure, PrayerModel>> updatePrayer(PrayerModel prayer);
  Future<Either<Failure, bool>> deletePrayer(String id);
}
