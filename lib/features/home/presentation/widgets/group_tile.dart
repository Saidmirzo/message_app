import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:message_app/config/constants/app_colors.dart';
import 'package:message_app/config/constants/assets.dart';
import 'package:message_app/features/home/data/models/group_model.dart';

import '../../../../config/constants/app_text_styles.dart';
import '../../../../config/routes/routes.dart';
import '../../../../widgets/custom_avatar.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({
    super.key,
    required this.groupModel,
  });

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.chatPage, arguments: {
          "groupModel": groupModel,
        });
      },
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        child: Row(
          children: [
            CustomAvatar(image: Assets.images.user1,size:56.h ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(Assets.icons.group),
                      SizedBox(width: 3.w),
                      Text(
                        groupModel.groupName,
                        style: AppTextStyles.body18w7.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        formatTime(groupModel.recentMessageTime),
                        style: AppTextStyles.body14w4.copyWith(
                          color: AppColors.neutral200,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    groupModel.recentMessage.isEmpty
                        ? ""
                        : "${groupModel.recentMessageSenderName}: ${groupModel.recentMessage}",
                    style: AppTextStyles.body16w4.copyWith(
                      color: AppColors.neutral200,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    
  }

  String getTitle(String value) {
    return value.substring(value.indexOf('_') + 1);
  }

  String getGroupId(String value) {
    return value.substring(0, value.indexOf('_'));
  }

  String formatTime(String value) {
    DateTime date;
    if (value.isEmpty) {
      return "";
    } else {
      final int time = int.parse(value);
      date = DateTime.fromMillisecondsSinceEpoch(time);
    }
    return "${date.hour}:${date.minute}";
  }
}


