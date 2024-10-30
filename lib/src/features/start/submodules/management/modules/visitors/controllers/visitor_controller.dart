import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:church_control/src/shared/utils/pagination_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../models/visitor_model.dart';
import '../services/interfaces/visitor_service_interfaces.dart';
import '../view-model/visitor_view_model.dart';

part 'visitor_controller.g.dart';

// ignore: library_private_types_in_public_api
class VisitorController = _VisitorControllerBase with _$VisitorController;

abstract class _VisitorControllerBase with Store {
  @observable
  VisitorModel visitor = VisitorModel();

  @observable
  List<VisitorModel> visitors = [];

  @observable
  PaginationModel pagination = PaginationModel();

  @observable
  bool busy = false;

  IVisitorService service;

  _VisitorControllerBase(this.service);

  @computed
  VisitorViewModel get model => VisitorViewModel(
        id: visitor.sId,
        name: visitor.name,
        email: visitor.email,
        telephone: visitor.telephone,
        isChurchgoer: visitor.isChurchgoer,
        church: visitor.church,
        observations: visitor.observations,
      );

  Future<void> getVisitors(FilterOptions options) async {
    try {
      busy = true;
      var result = await service.getVisitors(options);
      result.fold((l) {}, (response) async {
        pagination = response.pagination;
        visitors = response.visitors;
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> deleteVisitor() async {
    try {
      busy = true;
      var result = await service.deleteVisitor(model);
      result.fold((l) {}, (_) async {});
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> updateVisitor() async {
    try {
      busy = true;
      var result = await service.updateVisitor(model);
      result.fold((l) {}, (_) async {
        Modular.to.navigate(AppRoutes.VISITOR);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> createVisitor() async {
    try {
      busy = true;
      var result = await service.createVisitor(model);
      result.fold((l) {}, (userCreateModel) async {
        Modular.to.navigate(AppRoutes.VISITOR);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }
}
