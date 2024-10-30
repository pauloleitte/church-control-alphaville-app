import 'dart:convert';

import 'package:church_control/src/core/config/app_constants.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:dartz/dartz.dart';
import '../../../features/start/submodules/configuration/view-models/user_view_model.dart';
import '../../../shared/errors/errors.dart';
import '../../../shared/services/local_storage_service.dart';
import '../models/login_request_model.dart';
import '../models/signup_request_model.dart';
import '../models/token_model.dart';
import '../models/user_model.dart';
import '../repositories/interfaces/user_repository_interface.dart';
import '../view-models/login_view_model.dart';
import '../view-models/signup_view_model.dart';
import 'interfaces/token_service_interface.dart';
import 'interfaces/user_service_interface.dart';

class UserService implements IUserService {
  final IUserRepository _userRepository;
  final ITokenService _tokenService;

  UserService(this._userRepository, this._tokenService);

  @override
  void dispose() {}

  @override
  Future<UserModel> getCurrentUser() async {
    var contains = await LocalStorageService.contains(AppConstants.USER_KEY);
    if (contains) {
      final res = jsonDecode(
              await LocalStorageService.getValue<String>(AppConstants.USER_KEY))
          as Map<String, dynamic>;
      return UserModel.fromJson(res);
    } else {
      return UserModel();
    }
  }

  @override
  Future<String> getUserEmail() async {
    var contains = await LocalStorageService.contains('email');
    if (contains) {
      var email = await LocalStorageService.getValue<String>('email');
      return email;
    } else {
      return "";
    }
  }

  @override
  Future<void> saveUserLocal(UserModel user) async {
    LocalStorageService.setValue<String>(
        AppConstants.USER_KEY, jsonEncode(user.toJson()));
  }

  @override
  Future<void> saveUserEmailLocal(String email) async {
    LocalStorageService.setValue<String>('email', email);
  }

  @override
  Future<Either<Failure, TokenModel>> login(LoginViewModel model) async {
    return await _userRepository
        .login(LoginRequestModel(email: model.email, password: model.password));
  }

  @override
  Future<Either<Failure, UserModel>> signup(SignupViewModel model) async {
    return await _userRepository.signup(SignupRequestModel(
        name: model.name,
        email: model.email,
        password: model.password,
        phone: model.phone));
  }

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    var token = await _tokenService.getCurrentToken();
    return _userRepository.getUser(token);
  }

  @override
  Future<Either<Failure, bool>> updatePassword(UserViewModel model) async {
    return await _userRepository.updatePassword(UserModel(
        sId: model.id,
        name: model.name,
        email: model.email,
        password: model.password,
        roles: model.roles,
        avatarUrl: model.avatarUrl,
        tokens: model.tokens,
        genre: model.genre,
        phone: model.phone));
  }

  @override
  Future<Either<Failure, UserModel>> updateUser(UserViewModel model) async {
    return await _userRepository.updateUser(UserModel(
        sId: model.id,
        name: model.name,
        email: model.email,
        password: model.password,
        roles: model.roles,
        avatarUrl: model.avatarUrl,
        tokens: model.tokens,
        genre: model.genre,
        phone: model.phone));
  }

  @override
  Future<Either<Failure, bool>> deleteUser(UserViewModel model) async {
    return await _userRepository.deleteUser(model.id!);
  }

  @override
  Future<Either<Failure, UserModel>> updateTokensUser(UserModel model) async {
    return await _userRepository.updateUser(model);
  }

  @override
  Future<Either<Failure, ResponseUsers>> getUsers(FilterOptions options) async {
    return await _userRepository.getUsers(options);
  }

  @override
  Future<Either<Failure, bool>> createUser(UserViewModel model) async {
    return await _userRepository.createUser(UserModel(
        name: model.name,
        email: model.email,
        roles: model.roles,
        password: "123",
        genre: model.genre,
        phone: model.phone));
  }

  @override
  Future<void> removeUserFromSharedPreferences() async {
    await LocalStorageService.remove(AppConstants.USER_KEY);
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsersByRole(String role) async {
    return await _userRepository.getUsersByRole(role);
  }
}
