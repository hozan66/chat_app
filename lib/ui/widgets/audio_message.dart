import 'package:flutter/material.dart';

import '../../network/models/chat_message_model.dart';
import '../../shared/constants/default_values.dart';
import '../../shared/styles/my_colors.dart';

class AudioMessage extends StatelessWidget {
  final ChatMessageModel message;

  const AudioMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: const EdgeInsets.symmetric(
        horizontal: myDefaultPadding * 0.75,
        vertical: myDefaultPadding / 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: MyColors.myPrimaryColor.withOpacity(
          message.isSender ? 1.0 : 0.1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.play_arrow,
            color: message.isSender ? Colors.white : MyColors.myPrimaryColor,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: myDefaultPadding / 2,
              ),
              child: Stack(
                clipBehavior: Clip.none, // Don't cut
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2.0,
                    color: message.isSender
                        ? Colors.white
                        : MyColors.myPrimaryColor.withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0.0,
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        color: message.isSender
                            ? Colors.white
                            : MyColors.myPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            '0.37',
            style: TextStyle(
              fontSize: 12.0,
              color: message.isSender ? Colors.white : null,
            ),
          ),
        ],
      ),
    );
  }
}
