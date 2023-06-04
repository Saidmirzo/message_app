class UserRegisterModel {
  late String fullName;
  late String email;
  late String password;
  late String userImage;

  UserRegisterModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.userImage,
  });

  UserRegisterModel copyWith({
    String? fullName,
    String? email,
    String? password,
    String? userImage,
  }) {
    return UserRegisterModel(
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        password: password ?? this.password,
        userImage: userImage ?? this.userImage);
  }

  UserRegisterModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fullName'] = fullName;
    data['email'] = email;
    data['password'] = password;
    data['userImage'] = userImage;
    return data;
  }
}
