import 'dart:async';

import 'package:church_control/src/core/config/theme_helper.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../controllers/student_controller.dart';
import '../models/student_model.dart';

class BodyStudent extends StatefulWidget {
  const BodyStudent({Key? key}) : super(key: key);

  @override
  State<BodyStudent> createState() => _BodyStudentState();
}

class _BodyStudentState extends ModularState<BodyStudent, StudentController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  String? _searchTerm = "";

  final PagingController<int, StudentModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _getStudents(pageKey);
    });
    super.initState();
  }

  Future _getStudents(int pageKey) async {
    await controller.getStudents(
        FilterOptions(page: pageKey, sort: "asc", name: _searchTerm));
    final isLastPage = pageKey == controller.pagination.totalPages;
    if (isLastPage) {
      _pagingController.appendLastPage(controller.students);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(controller.students, nextPageKey);
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

  Widget getCardStudent(StudentModel student) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.school,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          student.name!,
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.STUDENT_DETAIL, arguments: student);
        },
        subtitle: Text(
          style: Theme.of(context).textTheme.bodySmall,
          student.email!,
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
                    'Nome', 'Insira o nome do aluno', const Icon(Icons.search)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () =>
                      Future.sync(() => _pagingController.refresh()),
                  child: PagedListView<int, StudentModel>.separated(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<StudentModel>(
                      itemBuilder: (context, item, index) =>
                          getCardStudent(item),
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
