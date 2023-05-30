import 'package:flutter/material.dart';
import 'package:message_app/config/routes/routes.dart';

import '../../../../config/constants/app_text_styles.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({
    super.key,
    required this.title,
    required this.admin,
  });

  final String title;
  final String admin;

  @override
  Widget build(BuildContext context) {
    final String groupName = getTitle(title);
    final String groupId = getGroupId(title);

    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, Routes.chatPage, arguments: {
          "title": title,
          "userName": admin,
          "groupId":groupId,
        });
      },
      leading: CircleAvatar(
        child: Text(
          groupName.substring(0, 1),
          style: AppTextStyles.body32w5,
        ),
      ),
      title: Text(groupName),
      subtitle: Text("Admin: $admin"),
    );
  }

  String getTitle(String value) {
    return value.substring(value.indexOf('_') + 1);
  }

  String getGroupId(String value) {
    return value.substring(value.indexOf('_') + 1);
  }
}
