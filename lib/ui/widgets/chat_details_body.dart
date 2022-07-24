import '../../shared/constants/default_values.dart';
import 'chat_input_field.dart';
import 'message.dart';
import 'package:flutter/material.dart';

import '../../network/models/chat_message_model.dart';

class ChatDetailsBody extends StatelessWidget {
  const ChatDetailsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: myDefaultPadding,
            ),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: demoChatMessages.length,
              itemBuilder: (context, index) =>
                  Message(message: demoChatMessages[index]),
            ),
          ),
        ),
        ChatInputField(),
      ],
    );
  }
}
