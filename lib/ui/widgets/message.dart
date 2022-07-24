import 'audio_message.dart';
import 'message_status_dot.dart';
import 'text_message.dart';
import 'video_message.dart';
import 'package:flutter/material.dart';

import '../../network/models/chat_message_model.dart';
import '../../shared/constants/default_values.dart';

class Message extends StatelessWidget {
  final ChatMessageModel message;

  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  Widget messageContent(ChatMessageModel message) {
    switch (message.messageType) {
      case ChatMessageType.text:
        return TextMessage(message: message);
      case ChatMessageType.audio:
        return AudioMessage(message: message);
      case ChatMessageType.video:
        return const VideoMessage();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: myDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            // Used to add list to the current list
            const CircleAvatar(
              radius: 12.0,
              backgroundImage: AssetImage('assets/images/user_2.png'),
            ),
            const SizedBox(width: myDefaultPadding / 2),
          ],
          messageContent(message),
          if (message.isSender) MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }
}
