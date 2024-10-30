import 'dart:async';

import 'package:church_control/src/core/config/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';


import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../shared/utils/filter_options.dart';
import '../controllers/notice_controller.dart';
import '../models/notice_model.dart';

class BodyNotice extends StatefulWidget {
  const BodyNotice({Key? key}) : super(key: key);

  @override
  State<BodyNotice> createState() => _BodyNoticeState();
}

class _BodyNoticeState extends ModularState<BodyNotice, NoticeController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  String _searchTerm = "";

  final PagingController<int, NoticeModel> _pagingController =
      PagingController(firstPageKey: 1);

  Future _getNotices(int pageKey) async {
    await controller.getNotices(
        FilterOptions(page: pageKey, sort: "asc", name: _searchTerm));
    final isLastPage = pageKey == controller.pagination.totalPages;
    if (isLastPage) {
      _pagingController.appendLastPage(controller.notices);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(controller.notices, nextPageKey);
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
      _getNotices(pageKey);
    });
    super.initState();
  }

  Widget getCardNotice(NoticeModel notice) {
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
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.NOTICE_DETAIL, arguments: notice);
        },
        subtitle: Text(
          style: Theme.of(context).textTheme.bodySmall,
          DateFormat('dd/MM/yyyy').format(notice.updatedAt!),
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
                    'Nome', 'Insira o nome do aviso', const Icon(Icons.search)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () =>
                      Future.sync(() => _pagingController.refresh()),
                  child: PagedListView<int, NoticeModel>.separated(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<NoticeModel>(
                      itemBuilder: (context, item, index) =>
                          getCardNotice(item),
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
