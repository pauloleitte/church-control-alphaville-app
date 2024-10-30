import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/member_model.dart';
import '../../view-model/member_view_model.dart';

abstract class IMemberService extends Disposable {
  Future<Either<Failure, ResponseMembers>> getMembers(FilterOptions options);
  Future<Either<Failure, ResponseFindAllMembers>> findAll();
  Future<Either<Failure, ResponseBirthdayOfMonth>> getBirthdayOfMonth();
  Future<Either<Failure, MemberModel>> getMember(MemberViewModel notice);
  Future<Either<Failure, MemberModel>> createMember(MemberViewModel notice);
  Future<Either<Failure, MemberModel>> updateMember(MemberViewModel notice);
  Future<Either<Failure, bool>> deleteMember(MemberViewModel notice);
}
