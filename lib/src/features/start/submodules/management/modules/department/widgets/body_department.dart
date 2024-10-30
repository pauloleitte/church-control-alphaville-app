import 'dart:async';

import 'package:church_control/src/core/config/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../shared/utils/filter_options.dart';
import '../controllers/department_controller.dart';
import '../models/department_model.dart';

class BodyDepartment extends StatefulWidget {
  final DepartmentModel? department;
  const BodyDepartment({Key? key, this.department}) : super(key: key);

  @override
  State<BodyDepartment> createState() => _BodyDepartmentState();
}

class _BodyDepartmentState
    extends ModularState<BodyDepartment, DepartmentController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  String? _searchTerm = "";

  final PagingController<int, DepartmentModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _getDepartments(pageKey);
    });
    super.initState();
  }

  Future _getDepartments(int pageKey) async {
    await controller.getDepartments(
        FilterOptions(page: pageKey, sort: "asc", name: _searchTerm));
    final isLastPage = pageKey == controller.pagination.totalPages;
    if (isLastPage) {
      _pagingController.appendLastPage(controller.departments);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(controller.departments, nextPageKey);
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

  Widget getCardDepartment(DepartmentModel department) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.people_alt_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          department.name!,
        ),
        onTap: () {
          Modular.to
              .pushNamed(AppRoutes.DEPARTMENT_DETAIL, arguments: department);
        },
        subtitle: Text(
          style: Theme.of(context).textTheme.bodySmall,
          department.description!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
          child: controller.busy
              ? const Center(child: CircularProgressIndicator())
              : Padding(
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
                              'Nome',
                              'Insira o nome do departamento',
                              const Icon(Icons.search)),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: RefreshIndicator(
                            onRefresh: () =>
                                Future.sync(() => _pagingController.refresh()),
                            child:
                                PagedListView<int, DepartmentModel>.separated(
                              pagingController: _pagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<DepartmentModel>(
                                itemBuilder: (context, item, index) =>
                                    getCardDepartment(item),
                              ),
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                            )),
                      )
                    ],
                  ),
                ));
    });
  }
}
