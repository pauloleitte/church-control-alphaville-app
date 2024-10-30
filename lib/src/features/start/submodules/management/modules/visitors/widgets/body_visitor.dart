import 'dart:async';

import 'package:church_control/src/core/config/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../shared/utils/filter_options.dart';
import '../controllers/visitor_controller.dart';
import '../models/visitor_model.dart';

class BodyVisitor extends StatefulWidget {
  const BodyVisitor({Key? key}) : super(key: key);

  @override
  State<BodyVisitor> createState() => _BodyVisitorState();
}

class _BodyVisitorState extends ModularState<BodyVisitor, VisitorController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  String _searchTerm = "";

  final PagingController<int, VisitorModel> _pagingController =
      PagingController(firstPageKey: 1);

  Future _getVisitors(int pageKey) async {
    await controller.getVisitors(
        FilterOptions(page: pageKey, sort: "asc", name: _searchTerm));
    final isLastPage = pageKey == controller.pagination.totalPages;
    if (isLastPage) {
      _pagingController.appendLastPage(controller.visitors);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(controller.visitors, nextPageKey);
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
      _getVisitors(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Widget getCardVisitor(VisitorModel visitor) {
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
          visitor.name!,
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.VISITOR_DETAIL, arguments: visitor);
        },
        subtitle: Text(
          '${visitor.email}',
          style: Theme.of(context).textTheme.bodySmall,
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
                decoration: ThemeHelper().textInputDecoration('Nome',
                    'Insira o nome do visitante', const Icon(Icons.search)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () =>
                      Future.sync(() => _pagingController.refresh()),
                  child: PagedListView<int, VisitorModel>.separated(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<VisitorModel>(
                      itemBuilder: (context, item, index) =>
                          getCardVisitor(item),
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                  )),
            )
          ],
        ),
      ));
    });
  }
}
