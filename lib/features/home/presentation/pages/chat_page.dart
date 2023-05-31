import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:message_app/config/constants/app_colors.dart';

import '../bloc/home/home_bloc.dart';
import '../widgets/message_tile.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.title,
      required this.userName,
      required this.groupId});
  final String title;
  final String userName;
  final String groupId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetChatsEvent(groupId: widget.groupId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat"),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadedState) {
              return Stack(
                children: [
                  StreamBuilder(
                    stream: context.read<HomeBloc>().chats,
                    builder: (context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              reverse: true,
                              // dragStartBehavior: DragStartBehavior.down,
                              itemCount: snapshot.data.docs.length,
                              padding: EdgeInsets.symmetric(vertical: 100.h),
                              itemBuilder: (context, index) {
                                return MessageTile(
                                    message: snapshot.data.docs[index]
                                        ['message'],
                                    sender: snapshot.data.docs[index]['sender'],
                                    sentByMe: widget.userName ==
                                        snapshot.data.docs[index]['sender']);
                              },
                            )
                          : Center(
                              child: Text(
                                'EMPTY',
                              ),
                            );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70.h,
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                        color: AppColors.blue,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: textEditingController,
                          )),
                          IconButton(
                            onPressed: () {
                              context.read<HomeBloc>().add(
                                    SendMessageEvent(
                                        groupId: widget.groupId,
                                        userName: widget.userName,
                                        message: textEditingController.text),
                                  );
                              textEditingController.clear();
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
