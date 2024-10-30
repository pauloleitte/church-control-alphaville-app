import 'package:flutter/material.dart';
import '../../../../../../../shared/utils/multiselect-params.dart';

class LessonAttendancePage extends StatefulWidget {
  final MultiSelectParams params;
  const LessonAttendancePage({super.key, required this.params});

  @override
  State<LessonAttendancePage> createState() => _LessonAttendancePageState();
}

class _LessonAttendancePageState extends State<LessonAttendancePage> {
  final List<dynamic> _selectedItems = [];
  final List<dynamic> _values = [];
  List<dynamic> copy = [];
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    copy.addAll(widget.params.items);
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: copy.length,
                    itemBuilder: (ctx, i) {
                      final item = copy[i];
                      return CheckboxListTile(
                        checkColor: Theme.of(context).primaryColor,
                        fillColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                        value: _selectedItems.contains(item.sId),
                        title: Text(item.name),
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
