// ignore_for_file: library_private_types_in_public_api

import 'package:church_control/src/features/start/submodules/ebd/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/dashboard/models/daily_report_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BodyDailyReport extends StatefulWidget {
  const BodyDailyReport({super.key});

  @override
  _BodyDailyReportState createState() => _BodyDailyReportState();
}

class _BodyDailyReportState
    extends ModularState<BodyDailyReport, DashboardController> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await controller.getDailyReport();
  }

  Widget _buildCard({required DailyReport dailyReport}) {
    return Card(
      child: ListTile(
        title: Text(dailyReport.group!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Data: ${dailyReport.date}'),
            Text('Chave: ${dailyReport.key}'),
            Text('Alunos Presentes: ${dailyReport.studentsPresent}'),
            Text('Alunos Ausentes: ${dailyReport.studentsAbsent}'),
            Text('Oferta: R\$ ${dailyReport.offerValue}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text('Relatório gerado em: ${controller.reportDate}'),
                const SizedBox(
                  height: 16,
                ),
                ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCard(
                        dailyReport: controller.dailyReport[index],
                      );
                    },
                    itemCount: controller.dailyReport.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics()),
              ],
            ),
          ),
        ),
      );
    });
  }
}
