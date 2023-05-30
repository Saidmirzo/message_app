class UserModel {
  String? fullName;
  String? email;
  List<String>? groups;
  String? uid;

  UserModel({this.fullName, this.email, this.groups, this.uid});

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    groups = json['groups'].cast<String>();
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['groups'] = this.groups;
    data['uid'] = this.uid;
    return data;
  }
}
