import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../shared/errors/errors.dart';
import '../../models/login_request_model.dart';
import '../../models/signup_request_model.dart';
import '../../models/token_model.dart';
import '../../models/user_model.dart';

abstract class IUserRepository implements Disposable {
  Future<Either<Failure, TokenModel>> login(LoginRequestModel model);
  Future<Either<Failure, UserModel>> signup(SignupRequestModel model);
  Future<Either<Failure, UserModel>> getUser(TokenModel model);
  Future<Either<Failure, bool>> updatePassword(UserModel model);
  Future<Either<Failure, UserModel>> updateUser(UserModel model);
  Future<Either<Failure, bool>> deleteUser(String id);
  Future<Either<Failure, ResponseUsers>> getUsers(FilterOptions options);
  Future<Either<Failure, List<UserModel>>> getUsersByRole(String role);
  Future<Either<Failure, bool>> createUser(UserModel model);
}
