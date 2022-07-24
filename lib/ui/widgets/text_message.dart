import 'package:flutter/material.dart';

import '../../network/models/chat_message_model.dart';
import '../../shared/constants/default_values.dart';
import '../../shared/styles/my_colors.dart';

class TextMessage extends StatelessWidget {
  final ChatMessageModel message;

  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: myDefaultPadding * 0.75,
        vertical: myDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color:
            MyColors.myPrimaryColor.withOpacity(message.isSender ? 1.0 : 0.08),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: message.isSender
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1?.color,
        ),
      ),
    );
  }
}
