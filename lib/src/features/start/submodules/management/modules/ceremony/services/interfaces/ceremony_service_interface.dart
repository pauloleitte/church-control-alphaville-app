import 'package:church_control/src/shared/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';


import '../../../../../../../../shared/utils/filter_options.dart';
import '../../models/ceremony_model.dart';
import '../../view-models/ceremony_view_model.dart';

abstract class ICeremonyService implements Disposable {
  Future<Either<Failure, ResponseCeremonies>> getCeremonies(
      FilterOptions options);
  Future<Either<Failure, CeremonyModel>> getCeremony(CeremonyViewModel model);
  Future<Either<Failure, CeremonyModel>> createCeremony(
      CeremonyViewModel model);
  Future<Either<Failure, CeremonyModel>> updateCeremony(
      CeremonyViewModel model);
  Future<Either<Failure, bool>> deleteCeremony(CeremonyViewModel model);
  Future<Either<Failure, List<CeremonyModel>>> getCeremoniesOfDay(
      DateTime date);
}
