import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:message_app/logic/helper_functions.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_text_styles.dart';
import '../../../home/data/models/message_model.dart';

import '../bloc/chat/chat_bloc.dart';

class MessageTile extends StatefulWidget {
  final MessageModel messageModel;
  final List<MessageModel> listMessages;
  final int index;

  const MessageTile({
    Key? key,
    required this.messageModel,
    required this.listMessages,
    required this.index,
  }) : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  late bool sendByMe;

  @override
  void initState() {
    super.initState();

    sendByMe =
        context.read<ChatBloc>().userModel.uid == widget.messageModel.senderId;
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<ChatBloc>().userModel.uid ==
        widget.messageModel.senderId) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            formatTime(widget.messageModel.time ?? ""),
            style: AppTextStyles.body14w4.copyWith(
              color: AppColors.neutral200,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.h).copyWith(left: 12.w),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.primary400,
              borderRadius: BorderRadius.circular(16.r).copyWith(
                bottomRight: const Radius.circular(0),
              ),
            ),
            child: Text(
              widget.messageModel.message ?? "",
              style: AppTextStyles.body16w4.copyWith(
                color: AppColors.white,
              ),
            ),
          )
        ],
      );
    } else {
      return Row(
        children: [
          Visibility(
            visible: drawImage(),
            replacement: SizedBox(width: 40.h),
            child: ClipRRect(
              child: Container(
                height: 40.h,
                width: 40.h,
                margin: EdgeInsets.only(top: 25.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.indigo,
                  image: widget.messageModel.senderImage != null
                      ? DecorationImage(
                          image: NetworkImage(widget.messageModel.senderImage!),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        )
                      : null,
                ),
                child: widget.messageModel.senderImage == null
                    ? Text(
                        widget.messageModel.senderName!.substring(0, 1),
                        style: AppTextStyles.body32w5.copyWith(
                          color: AppColors.white,
                        ),
                      )
                    : null,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
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
                  widget.messageModel.senderName ?? '',
                  style: AppTextStyles.body12w4.copyWith(
                    color: AppColors.neutral200,
                  ),
                ),
                Text(
                  widget.messageModel.message ?? '',
                  style: AppTextStyles.body16w4.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          Text(
            formatTime(widget.messageModel.time ?? ""),
            style: AppTextStyles.body14w4.copyWith(
              color: AppColors.neutral200,
            ),
          )
        ],
      );
    }
  }

  bool drawImage() {
    if (widget.index - 1 >= 0) {
      return widget.listMessages[widget.index - 1].senderId !=
          widget.messageModel.senderId;
    } else {
      return true;
    }
  }
}
