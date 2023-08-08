import 'package:flutter/material.dart';

import '../../../../config/constants/all_constants.dart';
import '../../../../widgets/custom_avatar.dart';
import '../../../auth/data/models/user_model.dart';

class ParticipantsItem extends StatelessWidget {
  const ParticipantsItem({
    super.key,
    required this.userModel,
    required this.isSelected,
    required this.onTap,
  });
  final UserModel userModel;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CustomAvatar(
            size: 56,
            link: userModel.userImage,
            isSelected: isSelected,
          ),
          Text(
            "${userModel.fullName!.substring(0, 5)}...",
            style: AppTextStyles.body14w7.copyWith(
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}
