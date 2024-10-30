import 'package:string_validator/string_validator.dart' as validator;

class LoginViewModel {
  String? email = "";
  String? password = "";

  LoginViewModel({this.email, this.password});

  bool get isValidEmail => validator.isEmail(email ?? "");
  bool get isValidPassword =>
      password != null && password!.isNotEmpty && password!.length >= 3;
}
