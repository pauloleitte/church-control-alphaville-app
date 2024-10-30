// ignore_for_file: file_names
import 'package:church_control/src/core/config/app_routes.dart';
import 'package:church_control/src/core/config/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      locale: const Locale('pt', 'BR'),
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Church Control',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.AUTH,
      theme: ThemeHelper().themeData(),
    ).modular();
  }
}
