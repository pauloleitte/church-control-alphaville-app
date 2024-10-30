import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:church_control/src/shared/utils/pagination_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../models/notice_model.dart';
import '../services/interfaces/notice_service_interface.dart';
import '../view-model/notice_view_model.dart';

part 'notice_controller.g.dart';

// ignore: library_private_types_in_public_api
class NoticeController = _NoticeControllerBase with _$NoticeController;

abstract class _NoticeControllerBase with Store {
  final INoticeService _noticeService;

  _NoticeControllerBase(this._noticeService);

  @observable
  List<NoticeModel> notices = [];

  @observable
  NoticeModel notice = NoticeModel();

  @observable
  PaginationModel pagination = PaginationModel();

  @observable
  bool busy = false;

  @computed
  NoticeViewModel get model => NoticeViewModel(
        id: notice.sId,
        name: notice.name,
        description: notice.description,
      );

  Future<void> getNotices(FilterOptions options) async {
    try {
      if (options.page != null) {
        if (options.page == 1) busy = true;
      }
      busy = true;
      var result = await _noticeService.getNotices(options);
      result.fold((l) {}, (response) async {
        pagination = response.pagination;
        notices = response.notices;
      });
    } catch (e) {
       busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> deleteNotice() async {
    try {
      busy = true;
      var result = await _noticeService.deleteNotice(model);
      result.fold((l) {}, (_) async {});
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> createNotice() async {
    try {
      busy = true;
      var result = await _noticeService.createNotice(model);
      result.fold((l) {}, (_) async {
        Modular.to.navigate(AppRoutes.NOTICE);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> updateNotice() async {
    try {
      busy = true;
      var result = await _noticeService.updateNotice(model);
      result.fold((l) {}, (_) async {
        Modular.to.navigate(AppRoutes.NOTICE);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> getNotice() async {
    try {
      busy = true;
      var result = await _noticeService.getNotice(model);
      result.fold((l) {}, (notice) async {
        busy = false;
        this.notice = notice;
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }
}
