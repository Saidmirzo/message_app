class GroupModel {
  final String admin;
  final String groupIcon;
  final String groupId;
  final String groupName;
  final List members;
  final String recentMessage;
  final String recentMessageSenderName;
  final String recentMessageTime;
  GroupModel({
    required this.admin,
    required this.groupIcon,
    required this.groupId,
    required this.groupName,
    required this.members,
    required this.recentMessage,
    required this.recentMessageSenderName,
    required this.recentMessageTime,
  });
}
