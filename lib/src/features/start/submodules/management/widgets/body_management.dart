import 'package:church_control/src/core/config/app_constants.dart';
import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/auth/models/user_model.dart';
import '../../../../../core/auth/services/interfaces/user_service_interface.dart';
import '../../../store/start_store.dart';

class BodyManagement extends StatefulWidget {
  const BodyManagement({super.key});

  @override
  State<BodyManagement> createState() => _BodyManagementState();
}

class _BodyManagementState extends State<BodyManagement> {
  // ignore: non_constant_identifier_names
  final int INDEX_PAGE = 1;
  final StartStore store = Modular.get();
  var user = UserModel();
  bool isAdmin = false;
  bool isSuper = false;

  @override
  void initState() {
    _getUser();
    store.currentIndex = INDEX_PAGE;
    super.initState();
  }

  Future _getUser() async {
    var userService = Modular.get<IUserService>();
    user = await userService.getCurrentUser();
    setState(() {
      isAdmin = user.roles!.contains(AppConstants.ADMIN_ROLE);
      isSuper = user.roles!.contains(AppConstants.SUPER_ROLE);
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
              getCardItem(
                  'Avisos',
                  Icon(
                    Icons.notifications_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  AppRoutes.NOTICE),
              getCardItem(
                  'Cultos',
                  Icon(
                    Icons.church_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  AppRoutes.CEREMONY),
              isAdmin
                  ? getCardItem(
                      'Departamentos',
                      Icon(
                        Icons.people_alt_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      AppRoutes.DEPARTMENT)
                  : const SizedBox(),
              isAdmin
                  ? getCardItem(
                      'Membros',
                      Icon(
                        Icons.contact_page_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      AppRoutes.MEMBER)
                  : const SizedBox(),
              getCardItem(
                  'Orações',
                  Icon(
                    Icons.question_answer_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  AppRoutes.PRAYER),
              getCardItem(
                  'Visitantes',
                  Icon(
                    Icons.person_outline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  AppRoutes.VISITOR),
              isSuper
                  ? getCardItem(
                      'Usuários',
                      Icon(Icons.person_3,
                          color: Theme.of(context).colorScheme.secondary),
                      AppRoutes.USER)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
