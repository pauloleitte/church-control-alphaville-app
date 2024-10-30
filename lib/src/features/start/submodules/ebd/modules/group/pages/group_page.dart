import 'package:church_control/src/core/config/app_routes.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/group/widgets/body_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Salas de Aula',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Modular.to.navigate(AppRoutes.EBD),
        ),
      ),
      body: const BodyGroup(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.navigate(AppRoutes.GROUP_FORM);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
