import 'package:church_control/src/shared/errors/errors.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';

import '../models/member_model.dart';
import '../repositories/interfaces/member_repository_interface.dart';
import '../view-model/member_view_model.dart';
import 'interfaces/member_service_interface.dart';

class MemberService implements IMemberService {
  final IMemberRepository _memberRepository;
  MemberService(this._memberRepository);

  @override
  Future<Either<Failure, MemberModel>> createMember(
      MemberViewModel model) async {
    return _memberRepository.createMember(MemberModel(
        name: model.name,
        address: model.address,
        birthday: model.birthday,
        job: model.job,
        genre: model.genre,
        email: model.email,
        phone: model.phone));
  }

  @override
  Future<Either<Failure, bool>> deleteMember(MemberViewModel model) async {
    return _memberRepository.deleteMember(model.sId.toString());
  }

  @override
  Future<Either<Failure, MemberModel>> getMember(MemberViewModel model) async {
    return _memberRepository.getMember(model.sId.toString());
  }

  @override
  Future<Either<Failure, ResponseMembers>> getMembers(
      FilterOptions options) async {
    return _memberRepository.getMembers(options);
  }

  @override
  Future<Either<Failure, ResponseFindAllMembers>> findAll() async {
    return _memberRepository.findAllMembers();
  }

  @override
  Future<Either<Failure, MemberModel>> updateMember(
      MemberViewModel model) async {
    return _memberRepository.updateMember(MemberModel(
        sId: model.sId,
        name: model.name,
        address: model.address,
        job: model.job,
        email: model.email,
        genre: model.genre,
        birthday: model.birthday,
        phone: model.phone));
  }

  @override
  Future<Either<Failure, ResponseBirthdayOfMonth>> getBirthdayOfMonth() async {
    return _memberRepository.getBirthdayOfMonth();
  }

  @override
  void dispose() {}
}
