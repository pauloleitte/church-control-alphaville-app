import 'package:string_validator/string_validator.dart' as validator;

class SignupViewModel {
  String? name = "";
  String? email = "";
  String? password = "";
  String? phone = "";

  SignupViewModel({this.name, this.email, this.password, this.phone});

  bool get isValidEmail => validator.isEmail(email ?? "");

  bool get isValidPassword =>
      (password != null && password!.isNotEmpty && password!.length >= 3);

  bool get isValidName =>
      (name != null && name!.isNotEmpty && name!.length > 3);
}
