import 'package:chat_app/network/models/chat_model.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/components/filled_outline_button.dart';
import 'package:chat_app/shared/constants/default_values.dart';
import 'package:chat_app/shared/styles/my_colors.dart';
import 'package:chat_app/ui/screens/chat_details/chat_details_screen.dart';
import 'package:chat_app/ui/widgets/chat_card.dart';
import 'package:flutter/material.dart';

class AllChatsBody extends StatelessWidget {
  const AllChatsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(
            myDefaultPadding,
            0.0,
            myDefaultPadding,
            myDefaultPadding,
          ),
          color: MyColors.myPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(
                press: () {},
                text: 'Recent Message',
              ),
              const SizedBox(width: myDefaultPadding),
              FillOutlineButton(
                press: () {},
                text: 'Active',
                isFilled: false,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () {
                navigateTo(context, const ChatDetailsScreen());
              },
            ),
          ),
        ),
      ],
    );
  }
}
