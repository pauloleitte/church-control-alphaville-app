import 'package:church_control/src/core/config/app_constants.dart';
import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/widgets/subtitle_widget.dart';
import '../../../../../shared/widgets/title_widget.dart';
import '../../management/modules/ceremony/models/ceremony_model.dart';
import '../../management/modules/member/models/member_model.dart';
import '../../management/modules/notice/models/notice_model.dart';
import '../controllers/home_controller.dart';

class BodyHome extends StatefulWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends ModularState<BodyHome, HomeController> {
  // ignore: non_constant_identifier_names
  final int INDEX_PAGE = 0;
  bool isAdmin = false;
  @override
  void initState() {
    _init();
    controller.store.currentIndex = INDEX_PAGE;
    super.initState();
  }

  void _init() async {
    await controller.getUser();
    await controller.getWeeksAgenda();
    await controller.getBirthdayOfMonth();
    await controller.getCeremoniesOfDay(DateTime.now().toUtc().toLocal());
    isAdmin = controller.model.roles!.contains(AppConstants.ADMIN_ROLE);
  }

  Widget getNoticeCard(NoticeModel notice) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.notifications_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          notice.name!,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.NOTICE_DETAIL, arguments: notice);
        },
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(notice.updatedAt!),
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget getCeremonyCard(CeremonyModel ceremony) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.church,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          ceremony.name!,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.CEREMONY_DETAIL, arguments: ceremony);
        },
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(ceremony.date!),
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget getMemberCard(MemberModel member) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          member.name!,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.MEMBER_DETAIL, arguments: member);
        },
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(member.birthday!),
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return RefreshIndicator(
        onRefresh: () async => _init(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: controller.busy
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          buildTitle(
                              context: context,
                              title:
                                  'Olá, ${controller.model.name.toString().split(' ')[0]}'),
                          const SizedBox(
                            height: 16,
                          ),
                          isAdmin
                              ? Column(children: [
                                  subTitle(
                                      context: context,
                                      title: 'Agenda da semana'),
                                  (controller.notices.isNotEmpty
                                      ? SizedBox(
                                          height: controller.notices.length == 1
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  6
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                          child: Column(children: [
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                child: ListView.builder(
                                                    itemCount: controller
                                                        .notices.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return getNoticeCard(
                                                          controller
                                                              .notices[index]);
                                                    }),
                                              ),
                                            ),
                                          ]),
                                        )
                                      : const SizedBox()),
                                ])
                              : const SizedBox(),
                          const SizedBox(
                            height: 16,
                          ),
                          (controller.ceremonies.isNotEmpty
                              ? SizedBox(
                                  height: controller.ceremonies.length == 1
                                      ? MediaQuery.of(context).size.height / 3
                                      : MediaQuery.of(context).size.height / 4,
                                  child: Column(
                                    children: [
                                      subTitle(
                                          title: 'Cultos Hoje',
                                          context: context),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: ListView.builder(
                                              itemCount:
                                                  controller.ceremonies.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return getCeremonyCard(
                                                    controller
                                                        .ceremonies[index]);
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox()),
                          const SizedBox(
                            height: 16,
                          ),
                          (controller.members.isNotEmpty
                              ? SizedBox(
                                  height: controller.members.length == 1
                                      ? MediaQuery.of(context).size.height / 3
                                      : MediaQuery.of(context).size.height / 4,
                                  child: Column(
                                    children: [
                                      subTitle(
                                          title: 'Aniversariantes do Mês',
                                          context: context),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: ListView.builder(
                                              itemCount:
                                                  controller.members.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return getMemberCard(
                                                    controller.members[index]);
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox()),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      );
    });
  }
}
