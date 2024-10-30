import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/config/app_routes.dart';
import '../models/visitor_model.dart';
import '../widgets/body_visitor.dart';

class VisitorPage extends StatefulWidget {
  const VisitorPage({Key? key}) : super(key: key);

  @override
  State<VisitorPage> createState() => _VisitorPageState();
}

class _VisitorPageState extends State<VisitorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Visitantes',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Modular.to.navigate(AppRoutes.MANAGEMENT),
        ),
      ),
      body: const BodyVisitor(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to
              .navigate(AppRoutes.VISITOR_FORM, arguments: VisitorModel());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
