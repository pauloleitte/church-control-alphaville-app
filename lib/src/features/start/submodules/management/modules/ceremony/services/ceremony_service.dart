import 'package:church_control/src/shared/errors/errors.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../../shared/utils/filter_options.dart';
import '../models/ceremony_model.dart';
import '../repositories/interfaces/ceremony_repository_interface.dart';
import '../view-models/ceremony_view_model.dart';
import 'interfaces/ceremony_service_interface.dart';

class CeremonyService implements ICeremonyService {
  final ICeremonyRepository _ceremonyRepository;
  CeremonyService(this._ceremonyRepository);

  @override
  Future<Either<Failure, CeremonyModel>> createCeremony(
      CeremonyViewModel model) async {
    return await _ceremonyRepository.createCeremony(CeremonyModel(
        name: model.name,
        description: model.description,
        date: model.date,
        notices: model.notices,
        prayers: model.prayers,
        visitors: model.visitors));
  }

  @override
  Future<Either<Failure, ResponseCeremonies>> getCeremonies(
          FilterOptions options) async =>
      await _ceremonyRepository.getCeremonies(options);

  @override
  Future<Either<Failure, CeremonyModel>> getCeremony(
          CeremonyViewModel model) async =>
      await _ceremonyRepository.getCeremony(model.id.toString());

  @override
  Future<Either<Failure, CeremonyModel>> updateCeremony(
      CeremonyViewModel model) async {
    return await _ceremonyRepository.updateCeremony(CeremonyModel(
        sId: model.id,
        name: model.name,
        date: model.date,
        visitors: model.visitors,
        notices: model.notices,
        prayers: model.prayers,
        description: model.description));
  }

  @override
  Future<Either<Failure, bool>> deleteCeremony(CeremonyViewModel model) {
    return _ceremonyRepository.deleteCeremony(model.id.toString());
  }

  @override
  Future<Either<Failure, List<CeremonyModel>>> getCeremoniesOfDay(
          DateTime date) async =>
      await _ceremonyRepository.getCeremoniesOfDay(date);

  @override
  void dispose() {}
}
