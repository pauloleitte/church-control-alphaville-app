// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardController on _DashboardControllerBase, Store {
  late final _$busyAtom =
      Atom(name: '_DashboardControllerBase.busy', context: context);

  @override
  bool get busy {
    _$busyAtom.reportRead();
    return super.busy;
  }

  @override
  set busy(bool value) {
    _$busyAtom.reportWrite(value, super.busy, () {
      super.busy = value;
    });
  }

  late final _$dailyReportAtom =
      Atom(name: '_DashboardControllerBase.dailyReport', context: context);

  @override
  List<DailyReport> get dailyReport {
    _$dailyReportAtom.reportRead();
    return super.dailyReport;
  }

  @override
  set dailyReport(List<DailyReport> value) {
    _$dailyReportAtom.reportWrite(value, super.dailyReport, () {
      super.dailyReport = value;
    });
  }

  late final _$reportDateAtom =
      Atom(name: '_DashboardControllerBase.reportDate', context: context);

  @override
  String get reportDate {
    _$reportDateAtom.reportRead();
    return super.reportDate;
  }

  @override
  set reportDate(String value) {
    _$reportDateAtom.reportWrite(value, super.reportDate, () {
      super.reportDate = value;
    });
  }

  late final _$lightHouseReportAtom =
      Atom(name: '_DashboardControllerBase.lightHouseReport', context: context);

  @override
  List<LightHouseReport> get lightHouseReport {
    _$lightHouseReportAtom.reportRead();
    return super.lightHouseReport;
  }

  @override
  set lightHouseReport(List<LightHouseReport> value) {
    _$lightHouseReportAtom.reportWrite(value, super.lightHouseReport, () {
      super.lightHouseReport = value;
    });
  }

  late final _$getDailyReportAsyncAction =
      AsyncAction('_DashboardControllerBase.getDailyReport', context: context);

  @override
  Future<void> getDailyReport() {
    return _$getDailyReportAsyncAction.run(() => super.getDailyReport());
  }

  late final _$getLightHouseReportAsyncAction = AsyncAction(
      '_DashboardControllerBase.getLightHouseReport',
      context: context);

  @override
  Future<void> getLightHouseReport() {
    return _$getLightHouseReportAsyncAction
        .run(() => super.getLightHouseReport());
  }

  late final _$_DashboardControllerBaseActionController =
      ActionController(name: '_DashboardControllerBase', context: context);

  @override
  Future<String> listDailyReportToCsv() {
    final _$actionInfo = _$_DashboardControllerBaseActionController.startAction(
        name: '_DashboardControllerBase.listDailyReportToCsv');
    try {
      return super.listDailyReportToCsv();
    } finally {
      _$_DashboardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<String> listLightHouseReportToCsv() {
    final _$actionInfo = _$_DashboardControllerBaseActionController.startAction(
        name: '_DashboardControllerBase.listLightHouseReportToCsv');
    try {
      return super.listLightHouseReportToCsv();
    } finally {
      _$_DashboardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
busy: ${busy},
dailyReport: ${dailyReport},
reportDate: ${reportDate},
lightHouseReport: ${lightHouseReport}
    ''';
  }
}
