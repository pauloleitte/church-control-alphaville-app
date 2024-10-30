import 'dart:convert';

import 'package:church_control/src/features/start/submodules/ebd/modules/dashboard/models/lighthouse_report_model.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/dashboard/models/daily_report_model.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/dashboard/services/interfaces/dashboard_service_interface.dart';
import 'package:dartz/dartz.dart';
import 'package:church_control/src/shared/errors/errors.dart';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/services.dart';

import '../repositories/interfaces/dashboard_repository_interface.dart';

class DashBoardService implements IDashBoardService {
  final IDashBoardRepository _repository;

  DashBoardService(this._repository);

  @override
  Future<Either<Failure, List<DailyReport>>> getDailyReport(String date) {
    return _repository.getDailyReport(date);
  }

  @override
  Future<Either<Failure, List<LightHouseReport>>> getLightHouseReport(
      String date) {
    return _repository.getLightHouseReport(date);
  }

  @override
  void dispose() {}

  @override
  String listDailyReportToCsv(List<DailyReport> data) {
    const ListToCsvConverter converter = ListToCsvConverter();
    final List<List<dynamic>> csvData = [];
    csvData.add([
      "Data",
      "Sala",
      "Chave",
      "Oferta",
      "Alunos Ausentes",
      "Alunos Presentes"
    ]);
    for (var element in data) {
      csvData.add([
        element.date,
        element.group,
        element.key,
        element.offerValue,
        element.studentsAbsent,
        element.studentsPresent
      ]);
    }
    return converter.convert(csvData);
  }

  @override
  String listLightHouseReportToCsv(List<LightHouseReport> data) {
    const ListToCsvConverter converter = ListToCsvConverter();
    final List<List<dynamic>> csvData = [];
    csvData.add(["Sala", "Chamada Realizada?"]);
    for (var element in data) {
      csvData.add([element.group, element.hasAnApperanceAlredyBeenMade]);
    }
    return converter.convert(csvData);
  }

  @override
  Future<void> downloadDailyReport(String csvDailyReport) async {
    Uint8List bytes = Uint8List.fromList(utf8.encode(csvDailyReport));
    await FileSaver.instance.saveFile(
        name: 'RelatorioDiario', bytes: bytes, mimeType: MimeType.csv);
  }

  @override
  Future<void> downloadLightHouseReport(String csvLightHouseReport) async {
    Uint8List bytes = Uint8List.fromList(utf8.encode(csvLightHouseReport));
    await FileSaver.instance
        .saveFile(name: 'RelatorioFarol', bytes: bytes, mimeType: MimeType.csv);
  }
}
