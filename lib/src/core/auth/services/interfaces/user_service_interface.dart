import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../features/start/submodules/configuration/view-models/user_view_model.dart';
import '../../../../shared/errors/errors.dart';
import '../../models/token_model.dart';
import '../../models/user_model.dart';
import '../../view-models/login_view_model.dart';
import '../../view-models/signup_view_model.dart';

abstract class IUserService implements Disposable {
  Future<UserModel> getCurrentUser();
  Future<String> getUserEmail();
  Future<void> removeUserFromSharedPreferences();
  Future<void> saveUserLocal(UserModel user);
  Future<void> saveUserEmailLocal(String email);
  Future<Either<Failure, TokenModel>> login(LoginViewModel login);
  Future<Either<Failure, UserModel>> signup(SignupViewModel signup);
  Future<Either<Failure, UserModel>> getUser();
  Future<Either<Failure, bool>> updatePassword(UserViewModel model);
  Future<Either<Failure, UserModel>> updateUser(UserViewModel model);
  Future<Either<Failure, UserModel>> updateTokensUser(UserModel model);
  Future<Either<Failure, ResponseUsers>> getUsers(FilterOptions options);
  Future<Either<Failure, bool>> deleteUser(UserViewModel model);
  Future<Either<Failure, bool>> createUser(UserViewModel model);
  Future<Either<Failure, List<UserModel>>> getUsersByRole(String role);
}
