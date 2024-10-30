import 'package:church_control/src/core/config/app_constants.dart';
import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/auth/models/user_model.dart';
import '../../../../../core/auth/services/interfaces/user_service_interface.dart';

class BodyEbd extends StatefulWidget {
  const BodyEbd({super.key});

  @override
  State<BodyEbd> createState() => _BodyEbdState();
}

class _BodyEbdState extends State<BodyEbd> {
  var user = UserModel();
  bool isEbdAdminOrSuperAdmin = false;
  bool isSecretaryOrTeacher = false;

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  Future _getUser() async {
    var userService = Modular.get<IUserService>();
    user = await userService.getCurrentUser();
    setState(() {
      isEbdAdminOrSuperAdmin =
          user.roles!.contains(AppConstants.EBD_ADMIN_ROLE) ||
              user.roles!.contains(AppConstants.SUPER_ROLE);

      isSecretaryOrTeacher =
          user.roles!.contains(AppConstants.EBD_SECRETARY_ROLE) ||
              user.roles!.contains(AppConstants.EBD_TEACHER_ROLE);
    });
  }

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
              isEbdAdminOrSuperAdmin
                  ? getCardItem(
                      'Alunos',
                      Icon(
                        Icons.school,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      AppRoutes.STUDENT)
                  : const SizedBox(),
              isEbdAdminOrSuperAdmin
                  ? getCardItem(
                      'Salas',
                      Icon(
                        Icons.class_,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      AppRoutes.GROUP)
                  : const SizedBox(),
              isEbdAdminOrSuperAdmin || isSecretaryOrTeacher
                  ? getCardItem(
                      'Lições',
                      Icon(
                        Icons.bookmark,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      AppRoutes.LESSON)
                  : const SizedBox(),
              isEbdAdminOrSuperAdmin
                  ? getCardItem(
                      'Usuários',
                      Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      AppRoutes.USER_EBD)
                  : const SizedBox(),
              isEbdAdminOrSuperAdmin
                  ? getCardItem(
                      'Dashboard',
                      Icon(
                        Icons.dashboard,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      AppRoutes.DASHBOARD_EBD)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
