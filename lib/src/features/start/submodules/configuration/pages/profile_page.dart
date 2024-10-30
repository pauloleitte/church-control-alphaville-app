import 'package:flutter/material.dart';
import '../../../../../core/auth/models/user_model.dart';
import '../widgets/body_profile.dart';

class ProfilePage extends StatefulWidget {
  final UserModel? user;
  const ProfilePage({Key? key, this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil')
      ),
      body: BodyProfile(user: widget.user),
    );
  }
}
