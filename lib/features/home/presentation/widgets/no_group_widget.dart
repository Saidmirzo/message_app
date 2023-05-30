import 'package:flutter/material.dart';
import 'package:message_app/logic/helper_functions.dart';


class NoGroupsWidget extends StatefulWidget {
  const NoGroupsWidget({
    super.key,
  });

  @override
  State<NoGroupsWidget> createState() => _NoGroupsWidgetState();
}

class _NoGroupsWidgetState extends State<NoGroupsWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () => popUpDialog(context),
        icon: const Icon(Icons.add_box_outlined),
      ),
    );
  }
}
