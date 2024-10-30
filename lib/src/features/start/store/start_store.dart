import 'package:mobx/mobx.dart';

part 'start_store.g.dart';

// ignore: library_private_types_in_public_api
class StartStore = _StartStoreBase with _$StartStore;

abstract class _StartStoreBase with Store {
  @observable
  int currentIndex = 0;
}
