import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/styles/my_colors.dart';
import 'package:chat_app/ui/screens/all_chats/cubit/cubit.dart';
import 'package:chat_app/ui/screens/all_chats/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../widgets/all_chats_body.dart';
import '../user_chat/user_chat_screen.dart';

class AllChatsScreen extends StatelessWidget {
  const AllChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AllChatsCubit(),
      child: BlocConsumer<AllChatsCubit, AllChatsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final AllChatsCubit cubit = AllChatsCubit.get(context);
          return Scaffold(
            appBar: buildAppBar(),
            body: const AllChatsBody(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: MyColors.myPrimaryColor,
              child: const Icon(
                Icons.person_add_alt_1,
                color: Colors.white,
              ),
              onPressed: () {
                var uuid = const Uuid();
                String userId = uuid.v1();
                navigateTo(
                    context,
                    UserChatScreen(
                      userId: userId,
                    ));
              },
            ),
            bottomNavigationBar: buildBottomNavigationBar(cubit),
          );
        },
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(AllChatsCubit cubit) {
    return BottomNavigationBar(
      currentIndex: cubit.currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        cubit.changeBottomNav(value);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: 'Chats'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'People'),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
        BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 14.0,
              backgroundImage: AssetImage('assets/images/user_2.png'),
            ),
            label: 'Profile'),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      // Remove back button
      automaticallyImplyLeading: false,
      title: const Text('Chats'),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
