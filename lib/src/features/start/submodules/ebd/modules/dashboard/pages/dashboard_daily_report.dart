// ignore_for_file: library_private_types_in_public_api

import 'package:church_control/src/features/start/submodules/ebd/modules/dashboard/controllers/dashboard_controller.dart';

import '../widgets/body_daily_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/config/app_routes.dart';

class DashBoardDailyReport extends StatefulWidget {
  const DashBoardDailyReport({super.key});

  @override
  _DashBoardDailyReportState createState() => _DashBoardDailyReportState();
}

class _DashBoardDailyReportState
    extends ModularState<DashBoardDailyReport, DashboardController> {
  void _submit() {
    controller.listDailyReportToCsv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EBD - Relatório Diário',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Modular.to.navigate(AppRoutes.DASHBOARD_EBD),
        ),
        actions: [
          IconButton(
            onPressed: _submit,
            icon: const Icon(Icons.file_download),
          ),
        ],
      ),
      body: const BodyDailyReport(),
    );
  }
}
