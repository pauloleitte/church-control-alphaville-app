// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NoticeController on _NoticeControllerBase, Store {
  Computed<NoticeViewModel>? _$modelComputed;

  @override
  NoticeViewModel get model =>
      (_$modelComputed ??= Computed<NoticeViewModel>(() => super.model,
              name: '_NoticeControllerBase.model'))
          .value;

  late final _$noticesAtom =
      Atom(name: '_NoticeControllerBase.notices', context: context);

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

  late final _$noticeAtom =
      Atom(name: '_NoticeControllerBase.notice', context: context);

  @override
  NoticeModel get notice {
    _$noticeAtom.reportRead();
    return super.notice;
  }

  @override
  set notice(NoticeModel value) {
    _$noticeAtom.reportWrite(value, super.notice, () {
      super.notice = value;
    });
  }

  late final _$paginationAtom =
      Atom(name: '_NoticeControllerBase.pagination', context: context);

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
      Atom(name: '_NoticeControllerBase.busy', context: context);

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
notices: ${notices},
notice: ${notice},
pagination: ${pagination},
busy: ${busy},
model: ${model}
    ''';
  }
}
