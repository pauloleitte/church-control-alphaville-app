import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/controllers/lesson_controller.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/models/lesson_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:async';

import '../../../../../../../core/auth/models/user_model.dart';
import '../../../../../../../core/auth/services/interfaces/user_service_interface.dart';
import '../../../../../../../core/config/app_constants.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../core/config/theme_helper.dart';
import '../../../../../../../shared/utils/filter_options.dart';

class BodyLesson extends StatefulWidget {
  const BodyLesson({super.key});

  @override
  State<BodyLesson> createState() => _BodyLessonState();
}

class _BodyLessonState extends ModularState<BodyLesson, LessonController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  String? _searchTerm = "";

  final PagingController<int, LessonModel> _pagingController =
      PagingController(firstPageKey: 1);

  var user = UserModel();
  bool isEbdAdminOrSuperAdmin = false;
  bool isSecretaryOrTeacher = false;

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

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      checkFlowLessons(pageKey);
    });
    super.initState();
  }

  void checkFlowLessons(int pageKey) async {
    if (user.roles == null) {
      await _getUser();
      await controller.getGroupsByUserId(user.sId!);
    }
    if (isEbdAdminOrSuperAdmin) {
      _getLessons(pageKey);
    }
    else if (isSecretaryOrTeacher) {
      for (var group in controller.groupsByUser) {
        _getLessonsByUserId(pageKey, group.sId!);
      }
    }
  }

  Future _getLessons(int pageKey) async {
    await controller.getLessons(
        FilterOptions(page: pageKey, sort: "asc", name: _searchTerm));
    final isLastPage = pageKey == controller.pagination.totalPages;
    if (isLastPage) {
      _pagingController.appendLastPage(controller.lessons);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(controller.lessons, nextPageKey);
    }
  }

  Future _getLessonsByUserId(int pageKey, String groupId) async {
    await controller.getLessonsByGroupId(
        FilterOptions(page: pageKey, sort: "asc", groupId: groupId));
    final isLastPage = pageKey == controller.pagination.totalPages;
    if (isLastPage) {
      _pagingController.appendLastPage(controller.lessons);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(controller.lessons, nextPageKey);
    }
  }

  _filterSearchResults(String query) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isNotEmpty) {
        _searchTerm = query;
        _pagingController.refresh();
        return;
      } else {
        _searchTerm = "";
        _pagingController.refresh();
      }
    });
  }

  Widget getCardLesson(LessonModel lesson) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.book,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          lesson.name!,
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.LESSON_DETAIL, arguments: lesson);
        },
        subtitle: Text(
          style: Theme.of(context).textTheme.bodySmall,
          lesson.group!.name!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
              child: TextField(
                onChanged: (value) {
                  _filterSearchResults(value);
                },
                controller: editingController,
                decoration: ThemeHelper().textInputDecoration(
                    'Nome', 'Insira o nome da lição', const Icon(Icons.search)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () =>
                      Future.sync(() => _pagingController.refresh()),
                  child: PagedListView<int, LessonModel>.separated(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<LessonModel>(
                      itemBuilder: (context, item, index) =>
                          getCardLesson(item),
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                  )),
            )
          ],
        ),
      ));
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
