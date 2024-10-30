import 'package:church_control/src/core/config/app_routes.dart';
import 'package:church_control/src/shared/utils/multiselect-params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';


import '../../../../../../../core/config/theme_helper.dart';
import '../../member/models/member_model.dart';
import '../../notice/models/notice_model.dart';
import '../controllers/department_controller.dart';
import '../models/department_model.dart';

class BodyDepartmentForm extends StatefulWidget {
  final DepartmentModel? department;
  const BodyDepartmentForm({Key? key, this.department}) : super(key: key);

  @override
  State<BodyDepartmentForm> createState() => _BodyDepartmentFormState();
}

class _BodyDepartmentFormState
    extends ModularState<BodyDepartmentForm, DepartmentController> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    if (widget.department != null) {
      controller.department = widget.department!;
    }
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.department.sId == null) {
        await controller.createDepartment();
      } else {
        await controller.updateDepartment();
      }
    }
  }

  void _showMultiSelectMember() async {
    await controller.getMembers();
    final data = MultiSelectParams<MemberModel>(
        initialValue: controller.department.members ?? [],
        items: controller.members,
        title: "Membros");
    final results = await Modular.to
        .pushNamed(AppRoutes.DEPARTMENT_MEMBER, arguments: data);
    if (results != null) {
      final result = List<MemberModel>.from(results as Iterable<dynamic>);
      controller.department.members = result;
      setState(() {});
    }
  }

  void _showMultiSelectNotice() async {
    await controller.getNotices();
    final data = MultiSelectParams<NoticeModel>(
        initialValue: controller.department.notices ?? [],
        items: controller.notices,
        title: "Avisos");
    final results = await Modular.to
        .pushNamed(AppRoutes.DEPARTMENT_MEMBER, arguments: data);
    if (results != null) {
      final result = List<NoticeModel>.from(results as Iterable<dynamic>);
      controller.department.notices = result;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          alignment: Alignment.center,
          child: Form(
              key: _formKey,
              child: Column(children: [
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    initialValue: controller.department.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                    decoration: ThemeHelper().textInputDecoration(
                        'Nome', 'Insira o nome do departamento'),
                    onSaved: (value) {
                      controller.department.name = value;
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    maxLines: 8,
                    initialValue: controller.department.description,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Descrição é obrigatório';
                      }
                      return null;
                    },
                    decoration: ThemeHelper().textInputDecoration(
                        'Descrição', 'Insira uma descrição'),
                    onSaved: (value) {
                      controller.department.description = value;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: GestureDetector(
                        onTap: _showMultiSelectNotice,
                        child: Card(
                            color: Theme.of(context).primaryColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.notifications,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                Text(
                                  "Avisos",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                )
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: GestureDetector(
                        onTap: _showMultiSelectMember,
                        child: Card(
                            color: Theme.of(context).primaryColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.people,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                Text(
                                  "Membros",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                )
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: ThemeHelper().buttonBoxDecoration(context: context),
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(context),
                    onPressed: controller.busy ? null : save,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        "Salvar".toUpperCase(),
                        style: ThemeHelper().buttonTextStyle(context),
                      ),
                    ),
                  ),
                ),
              ])),
        ),
      );
    });
  }
}
