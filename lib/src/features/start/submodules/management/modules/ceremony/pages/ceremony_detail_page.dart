import 'package:church_control/src/core/config/app_constants.dart';
import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import '../../../../../../../core/auth/models/user_model.dart';
import '../../../../../../../core/auth/services/interfaces/user_service_interface.dart';
import '../models/ceremony_model.dart';

class CeremonyDetailPage extends StatefulWidget {
  final CeremonyModel? ceremony;
  const CeremonyDetailPage({super.key, this.ceremony});

  @override
  State<CeremonyDetailPage> createState() => _CeremonyDetailPageState();
}

class _CeremonyDetailPageState extends State<CeremonyDetailPage> {
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
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text(widget.ceremony!.name!), actions: [
        isAdmin
            ? IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => {
                  Modular.to.navigate(AppRoutes.CEREMONY_FORM,
                      arguments: widget.ceremony)
                },
              )
            : const SizedBox(),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Text(widget.ceremony!.description!,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center),
              const SizedBox(height: 24.0),
              //Coluna Avisos
              SizedBox(
                height: deviceSize.height / 5,
                child: Column(
                  children: [
                    Text("Avisos",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor)),
                    const SizedBox(height: 16.0),
                    widget.ceremony!.notices != null &&
                            widget.ceremony!.notices!.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: widget.ceremony!.notices!.length,
                              itemBuilder: (context, index) {
                                final notice = widget.ceremony!.notices![index];
                                return Card(
                                  elevation: 10,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      child: Icon(
                                        Icons.notifications_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                    title: Text(
                                      notice.name!,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    onTap: () {
                                      Modular.to.pushNamed(
                                          AppRoutes.NOTICE_DETAIL,
                                          arguments: notice);
                                    },
                                    subtitle: Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(notice.updatedAt!),
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
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              //Coluna Visitantes
              SizedBox(
                height: deviceSize.height / 5,
                child: Column(
                  children: [
                    Text("Visitantes",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor)),
                    const SizedBox(height: 16.0),
                    widget.ceremony!.visitors != null &&
                            widget.ceremony!.visitors!.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: widget.ceremony!.visitors!.length,
                              itemBuilder: (context, index) {
                                final visitor =
                                    widget.ceremony!.visitors![index];
                                return Card(
                                  elevation: 10,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      child: Icon(
                                        Icons.person,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                    title: Text(
                                      visitor.name!,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    onTap: () {
                                      Modular.to.pushNamed(
                                          AppRoutes.VISITOR_DETAIL,
                                          arguments: visitor);
                                    },
                                    subtitle: Text(
                                      visitor.email!,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : const Text("Nenhum Visitante"),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              //Coluna Pedido de Orações
              SizedBox(
                height: deviceSize.height / 5,
                child: Column(
                  children: [
                    Text("Pedidos de Oração",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor)),
                    const SizedBox(height: 16.0),
                    widget.ceremony!.prayers != null &&
                            widget.ceremony!.prayers!.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: widget.ceremony!.prayers!.length,
                              itemBuilder: (context, index) {
                                final prayer = widget.ceremony!.prayers![index];
                                return Card(
                                  elevation: 10,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      child: Icon(
                                        Icons.question_answer_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                    title: Text(
                                      prayer.name!,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    onTap: () {
                                      Modular.to.pushNamed(
                                          AppRoutes.PRAYER_DETAIL,
                                          arguments: prayer);
                                    },
                                    subtitle: Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(prayer.updatedAt!),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : const Text("Nenhuma oração"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
