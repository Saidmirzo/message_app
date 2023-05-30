class UserRegisterModel {
  late String fullName;
  late String email;
  late String password;

  UserRegisterModel(
      {required this.fullName, required this.email, required this.password});

  UserRegisterModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
