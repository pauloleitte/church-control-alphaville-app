// ignore_for_file: file_names
class MultiSelectParams<T> {
  List<dynamic> items = [];
  String title = "";
  List<T> initialValue = [];

  MultiSelectParams(
      {required this.items, required this.title, required this.initialValue});
}
