class UserModel {
  String? email;
  String? userImage;
  String? uid;
  List<String>? groups;
  String? fullName;

  UserModel({this.email, this.userImage, this.uid, this.groups, this.fullName});

  UserModel copyWith({
    String? fullName,
    String? email,
    String? userImage,
  }) {
    return UserModel(
      email: email ?? this.email,
      userImage: userImage ?? this.userImage,
      uid: uid,
      groups: groups,
      fullName: fullName ?? this.fullName,

    );
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userImage = json['userImage'];
    uid = json['uid'];
    groups = json['groups'].cast<String>();
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = this.email;
    data['userImage'] = this.userImage;
    data['uid'] = this.uid;
    data['groups'] = this.groups;
    data['fullName'] = this.fullName;
    return data;
  }
}
