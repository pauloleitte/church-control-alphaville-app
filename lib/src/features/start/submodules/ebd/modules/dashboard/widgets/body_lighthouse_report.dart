// ignore_for_file: library_private_types_in_public_api

import 'package:church_control/src/features/start/submodules/ebd/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BodyLighthouseReport extends StatefulWidget {
  const BodyLighthouseReport({super.key});

  @override
  _BodyLighthouseReportState createState() => _BodyLighthouseReportState();
}

class _BodyLighthouseReportState
    extends ModularState<BodyLighthouseReport, DashboardController> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await controller.getLightHouseReport();
  }

  Widget _buildCard({required String title, required String value}) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
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
                        title: controller.lightHouseReport[index].group!,
                        value: controller.lightHouseReport[index]
                                .hasAnApperanceAlredyBeenMade!
                            ? 'Sim'
                            : 'Não',
                      );
                    },
                    itemCount: controller.lightHouseReport.length,
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
