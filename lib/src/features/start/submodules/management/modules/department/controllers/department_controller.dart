
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../shared/utils/pagination_model.dart';
import '../../member/models/member_model.dart';
import '../../member/services/interfaces/member_service_interface.dart';
import '../../notice/models/notice_model.dart';
import '../../notice/services/interfaces/notice_service_interface.dart';
import '../models/department_model.dart';
import '../services/interfaces/department_service_interface.dart';
import '../view-models/department_view_model.dart';

part 'department_controller.g.dart';

// ignore: library_private_types_in_public_api
class DepartmentController = _DepartmentControllerBase
    with _$DepartmentController;

abstract class _DepartmentControllerBase with Store {
  @observable
  DepartmentModel department = DepartmentModel();

  @observable
  PaginationModel pagination = PaginationModel();

  @observable
  List<MemberModel> members = [];

  @observable
  List<NoticeModel> notices = [];

  @observable
  bool busy = false;


  final IDepartmentService service;
  final IMemberService _memberService;
  final INoticeService _noticeService;

  _DepartmentControllerBase(
      this.service, this._memberService, this._noticeService);

  @observable
  List<DepartmentModel> departments = [];

  @computed
  DepartmentViewModel get model => DepartmentViewModel(
      id: department.sId,
      name: department.name,
      description: department.description,
      notices: department.notices,
      members: department.members);

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

  Future<void> getMembers() async {
    try {
      busy = true;
      var result = await _memberService.findAll();
      result.fold((l) {
        
      }, (response) async {
        busy = false;
        members = response.members!;
      });
    } catch (e) {
      busy = false;
      
    } finally {
      busy = false;
    }
  }

  Future<void> getDepartments(FilterOptions options) async {
    try {
      if (options.page != null) {
        if (options.page == 1) busy = true;
      }
      busy = true;
      var result = await service.getDepartments(options);
      result.fold((l) {
        
      }, (response) async {
        pagination = response.pagination;
        departments = response.departments;
      });
    } catch (e) {
       busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> deleteDepartment() async {
    try {
      busy = true;
      var result = await service.deleteDepartment(model);
      result.fold((l) {
        
      }, (_) async {
        
      });
    } catch (e) {
      busy = false;
      
    } finally {
      busy = false;
    }
  }

  Future<void> updateDepartment() async {
    try {
      busy = true;
      var result = await service.updateDepartment(model);
      result.fold((l) {
        
      }, (_) async {
        
        Modular.to.navigate(AppRoutes.DEPARTMENT);
      });
    } catch (e) {
      busy = false;
      
    } finally {
      busy = false;
    }
  }

  Future<void> createDepartment() async {
    try {
      busy = true;
      var result = await service.createDepartment(model);
      result.fold((l) {
        
      }, (_) async {
        
        Modular.to.navigate(AppRoutes.DEPARTMENT);
      });
    } catch (e) {
      busy = false;
      
    } finally {
      busy = false;
    }
  }
}
