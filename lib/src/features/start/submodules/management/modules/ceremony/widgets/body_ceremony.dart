import 'dart:async';

import 'package:church_control/src/core/config/theme_helper.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';


import '../../../../../../../core/config/app_routes.dart';
import '../controllers/ceremony_controller.dart';
import '../models/ceremony_model.dart';

class BodyCeremony extends StatefulWidget {
  const BodyCeremony({Key? key}) : super(key: key);

  @override
  State<BodyCeremony> createState() => _BodyCeremonyState();
}

class _BodyCeremonyState
    extends ModularState<BodyCeremony, CeremonyController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  String? _searchTerm = "";

  final PagingController<int, CeremonyModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _getCeremonies(pageKey);
    });
    super.initState();
  }

  Future _getCeremonies(int pageKey) async {
    await controller.getCeremonies(
        FilterOptions(page: pageKey, sort: "asc", name: _searchTerm));
    final isLastPage = pageKey == controller.pagination.totalPages;
    if (isLastPage) {
      _pagingController.appendLastPage(controller.ceremonies);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(controller.ceremonies, nextPageKey);
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

  Widget getCardCeremony(CeremonyModel ceremony) {
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
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.CEREMONY_DETAIL, arguments: ceremony);
        },
        subtitle: Text(
          style: Theme.of(context).textTheme.bodySmall,
          DateFormat('dd/MM/yyyy').format(ceremony.date!),
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
                    'Nome', 'Insira o nome do culto', const Icon(Icons.search)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () =>
                      Future.sync(() => _pagingController.refresh()),
                  child: PagedListView<int, CeremonyModel>.separated(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<CeremonyModel>(
                      itemBuilder: (context, item, index) =>
                          getCardCeremony(item),
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
