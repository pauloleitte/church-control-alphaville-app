import 'package:church_control/src/core/config/app_constants.dart';
import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/auth/models/user_model.dart';
import '../../../../../../../core/auth/services/interfaces/user_service_interface.dart';
import '../models/department_model.dart';

class DepartmentDetailPage extends StatefulWidget {
  final DepartmentModel? department;
  const DepartmentDetailPage({super.key, this.department});

  @override
  State<DepartmentDetailPage> createState() => _DepartmentDetailPageState();
}

class _DepartmentDetailPageState extends State<DepartmentDetailPage> {
  var user = UserModel();
  bool isAdmin = false;

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  Future _getUser() async {
    var userService = Modular.get<IUserService>();
    user = await userService.getCurrentUser();
    setState(() {
      isAdmin = user.roles!.contains(AppConstants.ADMIN_ROLE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.department!.name!), actions: [
        isAdmin
            ? IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => {
                  Modular.to.navigate(AppRoutes.DEPARTMENT_FORM,
                      arguments: widget.department)
                },
              )
            : const SizedBox(),
      ]),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                Text(widget.department!.name!,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center),
                Text(widget.department!.description!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center),
                const SizedBox(height: 50.0),
                Text("Avisos",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
                const SizedBox(height: 20.0),
                widget.department!.notices != null
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: widget.department!.notices!.length,
                          itemBuilder: (context, index) {
                            final notice = widget.department!.notices![index];
                            return Card(
                              elevation: 10,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Icon(
                                    Icons.notifications_outlined,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                title: Text(
                                  notice.name!,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                onTap: () {
                                  Modular.to.pushNamed(AppRoutes.NOTICE_DETAIL,
                                      arguments: notice);
                                },
                                subtitle: Text(
                                  notice.description!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Text("Nenhum Aviso"),
                const SizedBox(height: 20.0),
                Text("Membros",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
                const SizedBox(height: 20.0),
                widget.department!.members != null
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: widget.department!.members!.length,
                          itemBuilder: (context, index) {
                            final member = widget.department!.members![index];
                            return Card(
                              elevation: 10,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Icon(
                                    Icons.person,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                title: Text(
                                  member.name!,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                onTap: () {
                                  Modular.to.pushNamed(AppRoutes.MEMBER_DETAIL,
                                      arguments: member);
                                },
                                subtitle: Text(
                                  member.email!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Text("Nenhum Membro"),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
