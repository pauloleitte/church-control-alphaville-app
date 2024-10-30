// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ceremony_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CeremonyController on _CeremonyControllerBase, Store {
  Computed<CeremonyViewModel>? _$modelComputed;

  @override
  CeremonyViewModel get model =>
      (_$modelComputed ??= Computed<CeremonyViewModel>(() => super.model,
              name: '_CeremonyControllerBase.model'))
          .value;

  late final _$ceremonyAtom =
      Atom(name: '_CeremonyControllerBase.ceremony', context: context);

  @override
  CeremonyModel get ceremony {
    _$ceremonyAtom.reportRead();
    return super.ceremony;
  }

  @override
  set ceremony(CeremonyModel value) {
    _$ceremonyAtom.reportWrite(value, super.ceremony, () {
      super.ceremony = value;
    });
  }

  late final _$paginationAtom =
      Atom(name: '_CeremonyControllerBase.pagination', context: context);

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

  late final _$visitorsAtom =
      Atom(name: '_CeremonyControllerBase.visitors', context: context);

  @override
  List<VisitorModel> get visitors {
    _$visitorsAtom.reportRead();
    return super.visitors;
  }

  @override
  set visitors(List<VisitorModel> value) {
    _$visitorsAtom.reportWrite(value, super.visitors, () {
      super.visitors = value;
    });
  }

  late final _$noticesAtom =
      Atom(name: '_CeremonyControllerBase.notices', context: context);

  @override
  List<NoticeModel> get notices {
    _$noticesAtom.reportRead();
    return super.notices;
  }

  @override
  set notices(List<NoticeModel> value) {
    _$noticesAtom.reportWrite(value, super.notices, () {
      super.notices = value;
    });
  }

  late final _$prayersAtom =
      Atom(name: '_CeremonyControllerBase.prayers', context: context);

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

  late final _$busyAtom =
      Atom(name: '_CeremonyControllerBase.busy', context: context);

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

  late final _$ceremoniesAtom =
      Atom(name: '_CeremonyControllerBase.ceremonies', context: context);

  @override
  List<CeremonyModel> get ceremonies {
    _$ceremoniesAtom.reportRead();
    return super.ceremonies;
  }

  @override
  set ceremonies(List<CeremonyModel> value) {
    _$ceremoniesAtom.reportWrite(value, super.ceremonies, () {
      super.ceremonies = value;
    });
  }

  @override
  String toString() {
    return '''
ceremony: ${ceremony},
pagination: ${pagination},
visitors: ${visitors},
notices: ${notices},
prayers: ${prayers},
busy: ${busy},
ceremonies: ${ceremonies},
model: ${model}
    ''';
  }
}
