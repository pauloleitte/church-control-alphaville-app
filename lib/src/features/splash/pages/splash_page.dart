import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
        child: AnimatedOpacity(
          opacity: controller.isVisible ? 1.0 : 0,
          duration: const Duration(milliseconds: 1200),
          child: Center(
            child: Center(
              child: Image.asset(
                'assets/images/logo_vila_yara.png',
                height: 700.0,
                width: 700.0,
              ),
            ),
          ),
        ),
      );
    });
  }
}
