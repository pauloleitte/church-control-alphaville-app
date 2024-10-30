class UserViewModel {
  String? id = "";
  String? name = "";
  String? password = "";
  String? email = "";
  String? phone = "";
  String? genre = "";
  String? avatarUrl = "";
  List<String>? tokens = [];
  List<String>? roles = [];

  UserViewModel(
      {this.name,
      this.password,
      this.email,
      this.phone,
      this.id,
      this.genre,
      this.tokens,
      this.roles,
      this.avatarUrl});
}
