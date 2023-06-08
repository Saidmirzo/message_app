class SearchGroupModel {
  final String groupId;
  final String groupName;
  final String admin;
  final String? groupImage;
  final int membersCount;
  SearchGroupModel({
     this.groupImage,
    required this.admin,
    required this.groupId,
    required this.groupName,
    required this.membersCount,
  });
}
