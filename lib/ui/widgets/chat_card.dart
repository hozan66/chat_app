import 'package:flutter/material.dart';

import '../../network/models/chat_model.dart';
import '../../shared/constants/default_values.dart';
import '../../shared/styles/my_colors.dart';

class ChatCard extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback press;

  const ChatCard({
    Key? key,
    required this.chat,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: myDefaultPadding,
          vertical: myDefaultPadding * 0.75,
        ),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 24.0,
                  backgroundImage: AssetImage(chat.image),
                ),
                if (chat.isActive)
                  Container(
                    width: 16.0,
                    height: 16.0,
                    decoration: BoxDecoration(
                      color: MyColors.myPrimaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 3.0,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: myDefaultPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.name,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8.0),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        chat.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.64,
              child: Text(chat.time),
            ),
          ],
        ),
      ),
    );
  }
}
