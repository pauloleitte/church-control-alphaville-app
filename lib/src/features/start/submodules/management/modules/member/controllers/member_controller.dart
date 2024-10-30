// ignore_for_file: library_private_types_in_public_api

import 'package:church_control/src/shared/utils/filter_options.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../shared/utils/pagination_model.dart';
import '../models/member_model.dart';
import '../services/interfaces/member_service_interface.dart';
import '../view-model/member_view_model.dart';

part 'member_controller.g.dart';

class MemberController = _MemberControllerBase with _$MemberController;

abstract class _MemberControllerBase with Store {
  final IMemberService _service;
  _MemberControllerBase(this._service);

  @observable
  bool busy = false;

  @observable
  MemberModel member = MemberModel();

  @observable
  PaginationModel pagination = PaginationModel();

  @observable
  List<MemberModel> members = [];

  @computed
  MemberViewModel get model => MemberViewModel(
      sId: member.sId,
      name: member.name,
      address: member.address,
      phone: member.phone,
      email: member.email,
      birthday: member.birthday,
      genre: member.genre,
      job: member.job);

  Future<void> getMembers(FilterOptions options) async {
    try {
      if (options.page != null) {
        if (options.page == 1) busy = true;
      }
      busy = true;
      var result = await _service.getMembers(options);
      result.fold((l) {}, (response) async {
        pagination = response.pagination;
        members = response.members;
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> deleteMembers() async {
    try {
      busy = true;
      var result = await _service.deleteMember(model);
      result.fold((l) {}, (_) async {
        Modular.to.navigate(AppRoutes.MEMBER);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> updateMember() async {
    try {
      busy = true;
      var result = await _service.updateMember(model);
      result.fold((l) {}, (_) async {
        Modular.to.navigate(AppRoutes.MEMBER);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> createMember() async {
    try {
      busy = true;
      var result = await _service.createMember(model);
      result.fold((l) {}, (_) async {
        Modular.to.navigate(AppRoutes.MEMBER);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }
}
