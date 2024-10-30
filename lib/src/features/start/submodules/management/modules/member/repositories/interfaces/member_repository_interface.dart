import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/member_model.dart';

abstract class IMemberRepository extends Disposable {
  Future<Either<Failure, ResponseMembers>> getMembers(FilterOptions options);
  Future<Either<Failure, ResponseFindAllMembers>> findAllMembers();
  Future<Either<Failure, ResponseBirthdayOfMonth>> getBirthdayOfMonth();
  Future<Either<Failure, MemberModel>> getMember(String id);
  Future<Either<Failure, MemberModel>> createMember(MemberModel member);
  Future<Either<Failure, MemberModel>> updateMember(MemberModel member);
  Future<Either<Failure, bool>> deleteMember(String id);
}
