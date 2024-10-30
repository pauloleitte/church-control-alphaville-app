import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:church_control/src/shared/utils/pagination_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../models/prayer_model.dart';
import '../services/interfaces/prayer_service_interface.dart';
import '../view-model/prayer_view_model.dart';

part 'prayer_controller.g.dart';

// ignore: library_private_types_in_public_api
class PrayerController = _PrayerControllerBase with _$PrayerController;

abstract class _PrayerControllerBase with Store {
  final IPrayerService _prayerService;

  _PrayerControllerBase(this._prayerService);

  @observable
  List<PrayerModel> prayers = [];

  @observable
  PrayerModel prayer = PrayerModel();

  @observable
  PaginationModel pagination = PaginationModel();

  @observable
  bool busy = false;

  @computed
  PrayerViewModel get model => PrayerViewModel(
        id: prayer.sId,
        name: prayer.name,
        description: prayer.description,
      );

  Future<void> getPrayers(FilterOptions options) async {
    try {
      if (options.page != null) {
        if (options.page == 1) busy = true;
      }
      busy = true;
      var result = await _prayerService.getPrayers(options);
      result.fold((l) {}, (response) async {
        pagination = response.pagination;
        prayers = response.prayers;
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> deletePrayer() async {
    try {
      busy = true;
      var result = await _prayerService.deletePrayer(model);
      result.fold((l) {}, (_) async {});
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> createPrayer() async {
    try {
      busy = true;
      var result = await _prayerService.createPrayer(model);
      result.fold((l) {}, (_) async {
        Modular.to.navigate(AppRoutes.PRAYER);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> updatePrayer() async {
    try {
      busy = true;
      var result = await _prayerService.updatePrayer(model);
      result.fold((l) {}, (_) async {
        Modular.to.navigate(AppRoutes.PRAYER);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> getPrayer() async {
    try {
      busy = true;
      var result = await _prayerService.getPrayer(model);
      result.fold((l) {}, (prayer) async {
        busy = false;
        this.prayer = prayer;
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }
}
