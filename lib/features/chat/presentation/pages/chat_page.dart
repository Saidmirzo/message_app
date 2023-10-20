import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_text_styles.dart';
import '../../../../config/constants/assets.dart';
import '../../../home/data/models/group_model.dart';
import '../../../home/data/models/message_model.dart';

import '../../../home/presentation/bloc/home/home_bloc.dart';
import '../../../home/presentation/widgets/custom_button.dart';
import '../bloc/chat/chat_bloc.dart';
import '../widgets/message_tile.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.groupModel,
  });

  final GroupModel groupModel;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final GroupModel groupModel = widget.groupModel;
  final TextEditingController textEditingController = TextEditingController();
  late final String userName =
      context.read<HomeBloc>().userModel.fullName ?? "Saidmirza";
  @override
  void initState() {
    super.initState();

    context.read<ChatBloc>().add(GetChatsEvent(groupId: groupModel.groupId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral900,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColor,
        title: const Text("Chat"),
        centerTitle: true,
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoadedState) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.chatBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  StreamBuilder(
                    stream: context.read<ChatBloc>().chats,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<MessageModel> messageList = snapshot.data;
                        messageList = messageList.reversed.toList();
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          reverse: true,
                          itemCount: messageList.length,
                          padding: EdgeInsets.symmetric(vertical: 100.h),
                          itemBuilder: (context, index) {
                            return MessageTile(
                              index: index,
                              listMessages: messageList,
                              messageModel: messageList[index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'EMPTY',
                          ),
                        );
                      }
                    },
                  ),
                  Positioned(
                    bottom: 30.h,
                    left: 0.w,
                    right: 0.w,
                    child: Container(
                      height: 56.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8.h),
                      decoration: BoxDecoration(
                        color: AppColors.neutral700,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          CustomButton(
                            onTap: () {},
                            color: AppColors.neutral600,
                            child: SvgPicture.asset(Assets.icons.paperClip),
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            child: TextField(
                              style: AppTextStyles.body16w4.copyWith(
                                color: AppColors.white,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write a message",
                                hintStyle: AppTextStyles.body16w4.copyWith(
                                  color: AppColors.neutral200,
                                ),
                              ),
                              controller: textEditingController,
                            ),
                          ),
                          CustomButton(
                            onTap: () {
                              context.read<ChatBloc>().add(
                                    SendMessageEvent(
                                      groupId: groupModel.groupId,
                                      message: textEditingController.text,
                                    ),
                                  );
                              textEditingController.clear();
                            },
                            child: SvgPicture.asset(Assets.icons.send),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
