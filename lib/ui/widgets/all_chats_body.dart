import '../../business_logic/bloc_exports.dart';
import '../../shared/components/components.dart';
import '../../shared/components/filled_outline_button.dart';
import '../../shared/constants/default_values.dart';
import '../../shared/styles/my_colors.dart';
import '../screens/user_chat/user_chat_screen.dart';
import 'chat_card.dart';
import 'package:flutter/material.dart';

class AllChatsBody extends StatelessWidget {
  const AllChatsBody({Key? key}) : super(key: key);

  // final String roomChatName = 'ali@gmail.com--with--mm@gmail.com';
  // final String authorName = 'ali@gmail.com';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserChatBloc, UserChatState>(
      builder: (context, state) {
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
                itemCount: state.chatsList.length,
                itemBuilder: (context, index) {
                  return ChatCard(
                    chat: state.chatsList[index],
                    press: () {
                      //todo
                      navigateTo(
                          context,
                          UserChatScreen(
                            roomChatName: state.chatsList[index].name,
                            authorName: state.chatsList[index].lastMessage,
                          ));
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
