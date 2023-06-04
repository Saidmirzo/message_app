class MessageModel {
  String? message;
  String? senderName;
  String? time;
  String? senderId;
  String? senderImage;

  MessageModel(
      {this.message,
      this.senderName,
      this.time,
      this.senderId,
      this.senderImage});

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    senderName = json['senderName'];
    time = json['time'];
    senderId = json['senderId'];
    senderImage = json['senderImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['senderName'] = this.senderName;
    data['time'] = this.time;
    data['senderId'] = this.senderId;
    data['senderImage'] = this.senderImage;
    return data;
  }
}
