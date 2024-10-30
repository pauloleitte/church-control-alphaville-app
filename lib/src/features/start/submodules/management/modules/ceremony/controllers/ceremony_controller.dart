import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../shared/utils/filter_options.dart';
import '../../../../../../../shared/utils/pagination_model.dart';
import '../../notice/models/notice_model.dart';
import '../../notice/services/interfaces/notice_service_interface.dart';
import '../../prayer/models/prayer_model.dart';
import '../../prayer/services/interfaces/prayer_service_interface.dart';
import '../../visitors/models/visitor_model.dart';
import '../../visitors/services/interfaces/visitor_service_interfaces.dart';
import '../models/ceremony_model.dart';
import '../services/interfaces/ceremony_service_interface.dart';
import '../view-models/ceremony_view_model.dart';

part 'ceremony_controller.g.dart';

// ignore: library_private_types_in_public_api
class CeremonyController = _CeremonyControllerBase with _$CeremonyController;

abstract class _CeremonyControllerBase with Store {
  @observable
  CeremonyModel ceremony = CeremonyModel();

  @observable
  PaginationModel pagination = PaginationModel();

  @observable
  List<VisitorModel> visitors = [];

  @observable
  List<NoticeModel> notices = [];

  @observable
  List<PrayerModel> prayers = [];

  @observable
  bool busy = false;

  final ICeremonyService service;
  final IVisitorService _visitorService;
  final INoticeService _noticeService;
  final IPrayerService _prayerService;

  _CeremonyControllerBase(this.service, this._visitorService,
      this._noticeService, this._prayerService);

  @observable
  List<CeremonyModel> ceremonies = [];

  @computed
  CeremonyViewModel get model => CeremonyViewModel(
      id: ceremony.sId,
      name: ceremony.name,
      date: ceremony.date,
      description: ceremony.description,
      notices: ceremony.notices,
      prayers: ceremony.prayers,
      visitors: ceremony.visitors);

  Future<void> getPrayers() async {
    try {
      busy = true;
      var result = await _prayerService.findAll();
      result.fold((l) {
        
      }, (response) async {
        prayers = response.prayers!;
      });
    } catch (e) {
       busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> getNotices() async {
    try {
      busy = true;
      var result = await _noticeService.findAll();
      result.fold((l) {
        
      }, (response) async {
        notices = response.notices!;
      });
    } catch (e) {
       busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> getVisitors() async {
    try {
      busy = true;
      var result = await _visitorService.findCreatedAtToday();
      result.fold((l) {
        
      }, (response) async {
        visitors = response.visitors!;
      });
    } catch (e) {
       busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> getCeremonies(FilterOptions options) async {
    try {
      if (options.page != null) {
        if (options.page == 1) busy = true;
      }
      var result = await service.getCeremonies(options);
      result.fold((l) {
        
      }, (response) async {
        pagination = response.pagination;
        ceremonies = response.ceremonies;
      });
    } catch (e) {
       busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> deleteCeremony() async {
    try {
      busy = true;
      var result = await service.deleteCeremony(model);
      result.fold((l) {
        
      }, (_) async {
        
        Modular.to.navigate(AppRoutes.CEREMONY);
      });
    } catch (e) {
      busy = false;
      
    } finally {
      busy = false;
    }
  }

  Future<void> updateCeremony() async {
    try {
      busy = true;
      var result = await service.updateCeremony(model);
      result.fold((l) {
        
      }, (_) async {
        
        Modular.to.navigate(AppRoutes.CEREMONY);
      });
    } catch (e) {
      busy = false;
      
    } finally {
      busy = false;
    }
  }

  Future<void> createCeremony() async {
    try {
      busy = true;
      var result = await service.createCeremony(model);
      result.fold((l) {
        
      }, (_) async {
        
        Modular.to.navigate(AppRoutes.CEREMONY);
      });
    } catch (e) {
      busy = false;
      
    } finally {
      busy = false;
    }
  }
}
