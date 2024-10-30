// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PrayerController on _PrayerControllerBase, Store {
  Computed<PrayerViewModel>? _$modelComputed;

  @override
  PrayerViewModel get model =>
      (_$modelComputed ??= Computed<PrayerViewModel>(() => super.model,
              name: '_PrayerControllerBase.model'))
          .value;

  late final _$prayersAtom =
      Atom(name: '_PrayerControllerBase.prayers', context: context);

  @override
  List<PrayerModel> get prayers {
    _$prayersAtom.reportRead();
    return super.prayers;
  }

  @override
  set prayers(List<PrayerModel> value) {
    _$prayersAtom.reportWrite(value, super.prayers, () {
      super.prayers = value;
    });
  }

  late final _$prayerAtom =
      Atom(name: '_PrayerControllerBase.prayer', context: context);

  @override
  PrayerModel get prayer {
    _$prayerAtom.reportRead();
    return super.prayer;
  }

  @override
  set prayer(PrayerModel value) {
    _$prayerAtom.reportWrite(value, super.prayer, () {
      super.prayer = value;
    });
  }

  late final _$paginationAtom =
      Atom(name: '_PrayerControllerBase.pagination', context: context);

  @override
  PaginationModel get pagination {
    _$paginationAtom.reportRead();
    return super.pagination;
  }

  @override
  set pagination(PaginationModel value) {
    _$paginationAtom.reportWrite(value, super.pagination, () {
      super.pagination = value;
    });
  }

  late final _$busyAtom =
      Atom(name: '_PrayerControllerBase.busy', context: context);

  @override
  bool get busy {
    _$busyAtom.reportRead();
    return super.busy;
  }

  @override
  set busy(bool value) {
    _$busyAtom.reportWrite(value, super.busy, () {
      super.busy = value;
    });
  }

  @override
  String toString() {
    return '''
prayers: ${prayers},
prayer: ${prayer},
pagination: ${pagination},
busy: ${busy},
model: ${model}
    ''';
  }
}
