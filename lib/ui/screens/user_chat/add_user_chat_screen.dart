import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../business_logic/bloc_exports.dart';
import '../../../network/end_points.dart';
import '../../../network/models/chat_model.dart';
import '../../../network/remote/dio_helper.dart';

class AddUserChatScreen extends StatelessWidget {
  AddUserChatScreen({
    Key? key,
  }) : super(key: key);

  final roomChatController = TextEditingController();
  final authorController = TextEditingController();

  void createChatRoomAPI({
    required String roomChatName,
  }) {
    DioHelper.postData(
      url: newConversationEndPoint,
      data: {
        'room': roomChatName,
        'data': [],
      },
    ).then((value) {
      log('Send Data createChatRoomAPI=${value.data}');
    }).catchError((error) {
      log('createChatRoomAPI Error=${error.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Add Room Chat',
            style: TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextField(
              autofocus: true,
              controller: roomChatController,
              decoration: const InputDecoration(
                label: Text('Room Chat'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          TextField(
            autofocus: true,
            controller: authorController,
            decoration: const InputDecoration(
              label: Text('Author'),
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  //todo
                  createChatRoomAPI(
                    roomChatName: roomChatController.text,
                  );

                  // chatsData.add(
                  //   ChatModel(
                  //     name: roomChatController.text,
                  //     lastMessage: authorController.text,
                  //     image: "assets/images/welcome_image.png",
                  //     time: "3m ago",
                  //     isActive: false,
                  //   ),
                  // );

                  ChatModel chat = ChatModel(
                    name: roomChatController.text,
                    lastMessage: authorController.text,
                    image: "assets/images/welcome_image.png",
                    time: "3m ago",
                    isActive: false,
                  );

                  context
                      .read<UserChatBloc>()
                      .add(AddUserChatEvent(chat: chat));
                  // titleController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
