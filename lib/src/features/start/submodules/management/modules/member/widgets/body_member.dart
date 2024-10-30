import 'dart:async';

import 'package:church_control/src/core/config/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../shared/utils/filter_options.dart';
import '../controllers/member_controller.dart';
import '../models/member_model.dart';

class BodyMember extends StatefulWidget {
  const BodyMember({Key? key}) : super(key: key);

  @override
  State<BodyMember> createState() => _BodyMemberState();
}

class _BodyMemberState extends ModularState<BodyMember, MemberController> {
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;
  String _searchTerm = "";

  final PagingController<int, MemberModel> _pagingController =
      PagingController(firstPageKey: 1);

  Future _getMembers(int pageKey) async {
    await controller.getMembers(
        FilterOptions(page: pageKey, sort: "asc", name: _searchTerm));
    final isLastPage = pageKey == controller.pagination.totalPages;
    if (isLastPage) {
      _pagingController.appendLastPage(controller.members);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(controller.members, nextPageKey);
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
      _getMembers(pageKey);
    });
    super.initState();
  }

  Widget getCardMember(MemberModel member) {
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
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.MEMBER_DETAIL, arguments: member);
        },
        subtitle: Text(
          style: Theme.of(context).textTheme.bodySmall,
          '${member.job}',
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
                      'Insira o nome do membro', const Icon(Icons.search)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: RefreshIndicator(
                    onRefresh: () =>
                        Future.sync(() => _pagingController.refresh()),
                    child: PagedListView<int, MemberModel>.separated(
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<MemberModel>(
                        itemBuilder: (context, item, index) =>
                            getCardMember(item),
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                    )),
              )
            ],
          ),
        ),
      );
    });
  }
}
