import 'package:flutter/material.dart';
import '../../../../../core/auth/models/user_model.dart';
import '../widgets/body_security.dart';

class SecurityPage extends StatefulWidget {
  final UserModel? user;
  const SecurityPage({Key? key, this.user}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Segurança',
        ),
      ),
      body: BodySecurity(user: widget.user),
    );
  }
}
