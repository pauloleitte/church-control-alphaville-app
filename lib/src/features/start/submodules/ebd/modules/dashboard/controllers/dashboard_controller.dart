// ignore_for_file: library_private_types_in_public_api

import 'package:church_control/src/features/start/submodules/ebd/modules/dashboard/models/daily_report_model.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/dashboard/models/lighthouse_report_model.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/dashboard/services/interfaces/dashboard_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'dashboard_controller.g.dart';

class DashboardController = _DashboardControllerBase with _$DashboardController;

abstract class _DashboardControllerBase with Store {
  final IDashBoardService _dashboardService;

  _DashboardControllerBase(this._dashboardService);

  @observable
  bool busy = false;

  @observable
  List<DailyReport> dailyReport = [];

  @observable
  String reportDate =
      DateFormat('dd/MM/yyyy').format(DateTime.now().toUtc().toLocal());

  @observable
  List<LightHouseReport> lightHouseReport = [];

  @action
  Future<void> getDailyReport() async {
    final date =
        DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc().toLocal());
    try {
      final result = await _dashboardService.getDailyReport(date);
      result.fold((l) => {}, (r) => {dailyReport = r});
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  @action
  Future<void> getLightHouseReport() async {
    final date =
        DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc().toLocal());
    try {
      final result = await _dashboardService.getLightHouseReport(date);
      result.fold((l) => {}, (r) => {lightHouseReport = r});
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  @action
  Future<String> listDailyReportToCsv() {
    final csv = _dashboardService.listDailyReportToCsv(dailyReport);
    _dashboardService.downloadDailyReport(csv);
    debugPrint(csv);
    return Future.value(csv);
  }

  @action
  Future<String> listLightHouseReportToCsv() {
    final csv = _dashboardService.listLightHouseReportToCsv(lightHouseReport);
    _dashboardService.downloadLightHouseReport(csv);
    debugPrint(csv);
    return Future.value(csv);
  }
}
