import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/body_ceremony.dart';

class CeremonyPage extends StatefulWidget {
  const CeremonyPage({Key? key}) : super(key: key);

  @override
  State<CeremonyPage> createState() => _CeremonyPageState();
}

class _CeremonyPageState extends State<CeremonyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cultos',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Modular.to.navigate(AppRoutes.MANAGEMENT),
        ),
      ),
      body: const BodyCeremony(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.navigate(AppRoutes.CEREMONY_FORM);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
