import '../../network/models/chat_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/filled_outline_button.dart';
import '../../shared/constants/default_values.dart';
import '../../shared/styles/my_colors.dart';
import '../screens/chat_details/chat_details_screen.dart';
import 'chat_card.dart';
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
