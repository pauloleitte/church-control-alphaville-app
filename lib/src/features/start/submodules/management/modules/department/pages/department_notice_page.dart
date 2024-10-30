import 'package:church_control/src/shared/utils/multiselect-params.dart';
import 'package:flutter/material.dart';

class DepartmentNoticePage<T> extends StatefulWidget {
  final MultiSelectParams params;
  const DepartmentNoticePage({
    required this.params,
    Key? key,
  }) : super(key: key);

  @override
  State<DepartmentNoticePage> createState() => _DepartmentNoticePageState();
}

class _DepartmentNoticePageState extends State<DepartmentNoticePage> {
  // this variable holds the selected items
  final List<dynamic> _selectedItems = [];
  final List<dynamic> _values = [];

  @override
  void initState() {
    addInitialValueInSelectedItems();
    super.initState();
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
      body: SingleChildScrollView(
        child: ListBody(
          children: widget.params.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item.sId),
                    title: Text(item.name),
                    checkColor: Theme.of(context).primaryColor,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
