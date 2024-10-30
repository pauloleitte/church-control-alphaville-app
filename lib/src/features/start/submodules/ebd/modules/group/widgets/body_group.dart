import 'dart:async';

import 'package:church_control/src/features/start/submodules/ebd/modules/group/controllers/group_controller.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/group/models/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../core/config/theme_helper.dart';
import '../../../../../../../shared/utils/filter_options.dart';

class BodyGroup extends StatefulWidget {
  const BodyGroup({super.key});

  @override
  State<BodyGroup> createState() => _BodyGroupState();
}

class _BodyGroupState extends ModularState<BodyGroup, GroupController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  String? _searchTerm = "";

  final PagingController<int, GroupModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _getGroups(pageKey);
    });
    super.initState();
  }

  Future _getGroups(int pageKey) async {
    await controller.getGroups(
        FilterOptions(page: pageKey, sort: "asc", name: _searchTerm));
    final isLastPage = pageKey == controller.pagination.totalPages;
    if (isLastPage) {
      _pagingController.appendLastPage(controller.groups);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(controller.groups, nextPageKey);
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

  Widget getCardGroup(GroupModel group) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.class_,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          group.name!,
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.GROUP_DETAIL, arguments: group);
        },
        subtitle: Text(
          style: Theme.of(context).textTheme.bodySmall,
          group.sId!,
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
                    'Nome', 'Insira o nome da sala', const Icon(Icons.search)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () =>
                      Future.sync(() => _pagingController.refresh()),
                  child: PagedListView<int, GroupModel>.separated(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<GroupModel>(
                      itemBuilder: (context, item, index) => getCardGroup(item),
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
