import 'package:church_control/src/core/config/app_constants.dart';
import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/auth/models/user_model.dart';
import '../../../../../../../core/auth/services/interfaces/user_service_interface.dart';
import '../models/notice_model.dart';



class NoticeDetailPage extends StatefulWidget {
  final NoticeModel? notice;
  const NoticeDetailPage({super.key, this.notice});

  @override
  State<NoticeDetailPage> createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {
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
      appBar: AppBar(title: Text(widget.notice!.name!), actions: [
        isAdmin
            ? IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => {
                  Modular.to
                      .navigate(AppRoutes.NOTICE_FORM, arguments: widget.notice)
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
                  const SizedBox(height: 16.0),
                  Text(widget.notice!.description!,
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
