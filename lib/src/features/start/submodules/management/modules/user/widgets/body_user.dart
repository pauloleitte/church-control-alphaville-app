import 'dart:async';

import 'package:church_control/src/core/config/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../../../core/auth/models/user_model.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../shared/utils/filter_options.dart';
import '../controllers/user_controller.dart';

class BodyUser extends StatefulWidget {
  const BodyUser({Key? key}) : super(key: key);

  @override
  State<BodyUser> createState() => _BodyUserState();
}

class _BodyUserState extends ModularState<BodyUser, UserController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  String _searchTerm = "";

  final PagingController<int, UserModel> _pagingController =
      PagingController(firstPageKey: 1);

  Future _getUsers(int pageKey) async {
    await controller
        .getUsers(FilterOptions(page: pageKey, sort: "asc", name: _searchTerm));
    final isLastPage = pageKey == controller.pagination.totalPages;
    if (isLastPage) {
      _pagingController.appendLastPage(controller.users);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(controller.users, nextPageKey);
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

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _getUsers(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Widget getCardUser(UserModel user) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.person_3,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          user.name!,
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.USER_FORM, arguments: user);
        },
        subtitle: Text(
          '${user.email}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  'Nome', 'Insira o nome do usuário', const Icon(Icons.search)),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: RefreshIndicator(
                onRefresh: () => Future.sync(() => _pagingController.refresh()),
                child: PagedListView<int, UserModel>.separated(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<UserModel>(
                    itemBuilder: (context, item, index) => getCardUser(item),
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                )),
          )
        ],
      ),
    ));
  }
}
