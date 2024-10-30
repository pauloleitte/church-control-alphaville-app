// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../controllers/prayer_controller.dart';
import '../models/prayer_model.dart';
import '../widgets/body_prayer_form.dart';

class PrayerFormPage extends StatefulWidget {
  final PrayerModel? prayer;
  const PrayerFormPage({Key? key, this.prayer}) : super(key: key);

  @override
  State<PrayerFormPage> createState() => _PrayerFormPageState();
}

class _PrayerFormPageState
    extends ModularState<PrayerFormPage, PrayerController> {
  Future<void> onClickDelete() async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir'),
          content: Text("Deseja excluir o ${widget.prayer?.name}"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                controller.prayer = widget.prayer!;
                await controller.deletePrayer();
                Navigator.of(context).pop();
                Modular.to.navigate(AppRoutes.PRAYER);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Oração',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Modular.to.navigate(AppRoutes.PRAYER),
          ),
          actions: [
            ...(widget.prayer?.name != null
                ? [
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: onClickDelete,
                    ),
                  ]
                : [])
          ]),
      body: BodyPrayerForm(prayer: widget.prayer),
    );
  }
}
