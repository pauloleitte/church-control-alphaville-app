import 'package:church_control/src/features/start/submodules/ebd/modules/group/models/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/config/app_routes.dart';

class GroupDetailPage extends StatefulWidget {
  final GroupModel? group;
  const GroupDetailPage({super.key, this.group});

  @override
  State<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(widget.group!.name!), actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => {
            Modular.to.navigate(AppRoutes.GROUP_FORM, arguments: widget.group)
          },
        )
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Text(widget.group!.description!,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center),
              const SizedBox(height: 24.0),
              //Coluna Visitantes
              SizedBox(
                  height: deviceSize.height / 5,
                  child: Column(
                    children: [
                      Text("Professores",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor)),
                      const SizedBox(height: 16.0),
                      widget.group!.teachers != null &&
                              widget.group!.teachers!.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: widget.group!.teachers!.length,
                                itemBuilder: (context, index) {
                                  final teacher =
                                      widget.group!.teachers![index];
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
                                        teacher.name!,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      onTap: () {
                                        Modular.to.pushNamed(
                                            AppRoutes.USER_FORM,
                                            arguments: teacher);
                                      },
                                      subtitle: Text(
                                        teacher.email!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Center(
                              child: Text(
                                "Nenhum professor vinculado a esta sala de aula",
                              ),
                            ),
                    ],
                  )),
              const SizedBox(height: 24.0),
              //Coluna Visitantes
              SizedBox(
                  height: deviceSize.height / 5,
                  child: Column(
                    children: [
                      Text("Secretários",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor)),
                      const SizedBox(height: 16.0),
                      widget.group!.secretaries != null &&
                              widget.group!.secretaries!.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: widget.group!.secretaries!.length,
                                itemBuilder: (context, index) {
                                  final secretary =
                                      widget.group!.secretaries![index];
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
                                        secretary.name!,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      onTap: () {
                                        Modular.to.pushNamed(
                                            AppRoutes.USER_FORM,
                                            arguments: secretary);
                                      },
                                      subtitle: Text(
                                        secretary.email!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Text(
                              "Nenhum secretário vinculado a esta sala de aula"),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
