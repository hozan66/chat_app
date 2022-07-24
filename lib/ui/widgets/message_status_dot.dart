import 'package:chat_app/shared/constants/default_values.dart';
import 'package:chat_app/shared/styles/my_colors.dart';
import 'package:flutter/material.dart';

import '../../network/models/chat_message_model.dart';

class MessageStatusDot extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusDot({
    Key? key,
    required this.status,
  }) : super(key: key);

  Color dotColor(MessageStatus status, BuildContext context) {
    switch (status) {
      case MessageStatus.notSent:
        return MyColors.myErrorColor;
      case MessageStatus.notView:
        return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
      case MessageStatus.viewed:
        return MyColors.myPrimaryColor;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: myDefaultPadding / 2,
      ),
      width: 12.0,
      height: 12.0,
      decoration: BoxDecoration(
        color: dotColor(status, context),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.notSent ? Icons.close : Icons.done,
        size: 8.0,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
