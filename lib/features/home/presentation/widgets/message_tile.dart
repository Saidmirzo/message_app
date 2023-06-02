import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:message_app/config/constants/app_colors.dart';
import 'package:message_app/config/constants/app_text_styles.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sentByMe;

  const MessageTile({
    Key? key,
    required this.message,
    required this.sender,
    required this.sentByMe,
  }) : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    if (widget.sentByMe) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.h),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.primary400,
              borderRadius: BorderRadius.circular(16.r).copyWith(
                bottomRight: const Radius.circular(0),
              ),
            ),
            child: Text(
              widget.message,
              style: AppTextStyles.body16w4.copyWith(
                color: AppColors.white,
              ),
            ),
          )
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            child: Container(
              height: 40.h,
              width: 40.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.indigo,
              ),
              child: Text(
                widget.sender.substring(0, 1),
                style: AppTextStyles.body32w5.copyWith(color: AppColors.white),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.h),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.neutral800,
              borderRadius: BorderRadius.circular(16.r).copyWith(
                bottomLeft: const Radius.circular(0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.sender,
                  style: AppTextStyles.body12w4.copyWith(
                    color: AppColors.neutral200,
                  ),
                ),
                Text(
                  widget.message,
                  style: AppTextStyles.body16w4.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }
  }
}
