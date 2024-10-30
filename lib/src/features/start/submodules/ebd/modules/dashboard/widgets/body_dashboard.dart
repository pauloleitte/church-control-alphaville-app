// ignore_for_file: library_private_types_in_public_api

import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BodyDashboard extends StatefulWidget {
  const BodyDashboard({super.key});

  @override
  _BodyDashboardState createState() => _BodyDashboardState();
}

class _BodyDashboardState extends State<BodyDashboard> {
  Widget getCardItem(String name, Icon icon, String route) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).primaryColor,
              child: icon,
            ),
          ),
        ),
      ),
      onTap: () => {Modular.to.pushNamed(route)},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              getCardItem(
                  "Relatório Diário",
                  Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  AppRoutes.DASHBOARD_DAILY_REPORT_EBD),
              getCardItem(
                  "Relatório Farol",
                  Icon(
                    Icons.lightbulb,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  AppRoutes.DASHBORAD_LIGHTHOUSE_REPORT_EBD),
            ],
          ),
        ),
      ),
    );
  }
}
