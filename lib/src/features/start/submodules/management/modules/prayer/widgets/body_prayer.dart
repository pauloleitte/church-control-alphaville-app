import 'dart:async';

import 'package:church_control/src/core/config/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../shared/utils/filter_options.dart';
import '../controllers/prayer_controller.dart';
import '../models/prayer_model.dart';

class BodyPrayer extends StatefulWidget {
  const BodyPrayer({Key? key}) : super(key: key);

  @override
  State<BodyPrayer> createState() => _BodyPrayerState();
}

class _BodyPrayerState extends ModularState<BodyPrayer, PrayerController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  String _searchTerm = "";

  final PagingController<int, PrayerModel> _pagingController =
      PagingController(firstPageKey: 1);

  Future _getPrayers(int pageKey) async {
    await controller.getPrayers(
        FilterOptions(page: pageKey, sort: "asc", name: _searchTerm));
    final isLastPage = pageKey == controller.pagination.totalPages;
    if (isLastPage) {
      _pagingController.appendLastPage(controller.prayers);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(controller.prayers, nextPageKey);
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
      _getPrayers(pageKey);
    });
    super.initState();
  }

  Widget getCardPrayer(PrayerModel prayer) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.question_answer_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          prayer.name!,
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.PRAYER_DETAIL, arguments: prayer);
        },
        subtitle: Text(
          style: Theme.of(context).textTheme.bodySmall,
          DateFormat('dd/MM/yyyy').format(prayer.updatedAt!),
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
                  child: PagedListView<int, PrayerModel>.separated(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<PrayerModel>(
                      itemBuilder: (context, item, index) =>
                          getCardPrayer(item),
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                  )))
        ],
      ),
    ));
  }
}
