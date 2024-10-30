import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import '../../../../../../../shared/errors/errors.dart';
import '../models/prayer_model.dart';
import '../repositories/interfaces/prayer_repository_interface.dart';
import '../view-model/prayer_view_model.dart';
import 'interfaces/prayer_service_interface.dart';

class PrayerService implements IPrayerService {
  final IPrayerRepository _prayerRepository;

  PrayerService(this._prayerRepository);

  @override
  Future<Either<Failure, PrayerModel>> createPrayer(PrayerViewModel vm) async {
    return await _prayerRepository.createPrayer(PrayerModel(
      name: vm.name,
      description: vm.description,
    ));
  }

  @override
  Future<Either<Failure, bool>> deletePrayer(PrayerViewModel vm) async {
    return await _prayerRepository.deletePrayer(vm.id!);
  }

  @override
  void dispose() {}

  @override
  Future<Either<Failure, PrayerModel>> getPrayer(PrayerViewModel vm) {
    return _prayerRepository.getPrayer(vm.id!);
  }

  @override
  Future<Either<Failure, ResponsePrayers>> getPrayers(FilterOptions options) {
    return _prayerRepository.getPrayers(options);
  }

  @override
  Future<Either<Failure, ResponseFindAllPrayers>> findAll() {
    return _prayerRepository.findAll();
  }

  @override
  Future<Either<Failure, PrayerModel>> updatePrayer(PrayerViewModel vm) {
    return _prayerRepository.updatePrayer(PrayerModel(
      sId: vm.id,
      name: vm.name,
      description: vm.description,
    ));
  }
}
