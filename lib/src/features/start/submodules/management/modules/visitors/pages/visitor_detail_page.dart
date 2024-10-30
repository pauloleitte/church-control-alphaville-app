import 'package:church_control/src/core/config/app_constants.dart';
import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../../core/auth/models/user_model.dart';
import '../../../../../../../core/auth/services/interfaces/user_service_interface.dart';
import '../models/visitor_model.dart';

class VisitorDetailPage extends StatefulWidget {
  final VisitorModel? visitor;
  const VisitorDetailPage({super.key, this.visitor});

  @override
  State<VisitorDetailPage> createState() => _VisitorDetailPageState();
}

class _VisitorDetailPageState extends State<VisitorDetailPage> {
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
      appBar: AppBar(title: Text(widget.visitor!.name!), actions: [
        isAdmin
            ? IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => {
                  Modular.to.navigate(AppRoutes.VISITOR_FORM,
                      arguments: widget.visitor)
                },
              )
            : const SizedBox(),
      ]),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  Text(widget.visitor!.observations!,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
