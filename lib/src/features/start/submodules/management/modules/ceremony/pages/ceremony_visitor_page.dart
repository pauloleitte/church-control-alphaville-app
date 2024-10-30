import 'dart:async';

import 'package:church_control/src/shared/utils/multiselect-params.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/config/theme_helper.dart';

class CeremonyVisitorPage<T> extends StatefulWidget {
  final MultiSelectParams params;
  const CeremonyVisitorPage({
    required this.params,
    Key? key,
  }) : super(key: key);

  @override
  State<CeremonyVisitorPage> createState() => _CeremonyVisitorPageState();
}

class _CeremonyVisitorPageState extends State<CeremonyVisitorPage> {
  // this variable holds the selected items
  final List<dynamic> _selectedItems = [];
  final List<dynamic> _values = [];
  List<dynamic> copy = [];
  TextEditingController editingController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    copy.addAll(widget.params.items);
    addInitialValueInSelectedItems();
    super.initState();
  }

  _filterSearchResults(String query) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isNotEmpty) {
        setState(() {
          copy.removeWhere((item) => !item.name.contains(query));
        });
        return;
      } else {
        setState(() {
          copy.addAll(widget.params.items);
          copy.toSet().toList();
          addInitialValueInSelectedItems();
        });
        return;
      }
    });
  }

  void addInitialValueInSelectedItems() {
    setState(() {
      for (var element in widget.params.initialValue) {
        if (!_selectedItems.contains(element.sId)) {
          _selectedItems.add(element.sId);
        }
        if (!_values.contains(element)) {
          _values.add(element);
        }
      }
    });
  }

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(dynamic itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _values.add(itemValue);
        _selectedItems.add(itemValue.sId);
      } else {
        _values.removeWhere((model) => model.sId == itemValue.sId);
        _selectedItems.remove(itemValue.sId);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.params.title),
        leading: IconButton(
          onPressed: _cancel,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: _submit,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
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
                    'Nome', 'Insira um nome', const Icon(Icons.search)),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: copy.length,
                    itemBuilder: (ctx, i) {
                      final item = copy[i];
                      return CheckboxListTile(
                        value: _selectedItems.contains(item.sId),
                        title: Text(item.name),
                        checkColor: Theme.of(context).primaryColor,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) => _itemChange(item, isChecked!),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
