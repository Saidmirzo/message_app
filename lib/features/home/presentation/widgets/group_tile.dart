import 'package:flutter/material.dart';
import 'package:message_app/config/routes/routes.dart';
import 'package:message_app/features/home/data/models/group_model.dart';

import '../../../../config/constants/app_text_styles.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({
    super.key,
    required this.groupModel,
  });

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    // final String groupName = getTitle(title);
    // final String groupId = getGroupId(title);

    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, Routes.chatPage, arguments: {
          "title": groupModel.groupName,
          "userName": groupModel.admin,
          "groupId": groupModel.groupId,
        });
      },
      leading: CircleAvatar(
        child: Text(
          groupModel.groupName.substring(0, 1),
          style: AppTextStyles.body32w5,
        ),
      ),
      title: Text(groupModel.groupName),
      subtitle: Text(
          "Admin: ${groupModel.admin.substring(groupModel.admin.indexOf("_") + 1)}"),
    );
  }

  String getTitle(String value) {
    return value.substring(value.indexOf('_') + 1);
  }

  String getGroupId(String value) {
    return value.substring(0, value.indexOf('_'));
  }
}
