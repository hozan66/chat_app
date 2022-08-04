import 'package:chat_app/network/end_points.dart';
import 'package:chat_app/network/remote/dio_helper.dart';
import 'dart:developer';
import '../../../network/models/user_chat_model.dart';
import '../../../shared/constants/default_values.dart';
import 'package:flutter/material.dart';
import '../../../shared/styles/my_colors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class UserChatScreen extends StatefulWidget {
  final String roomChatName;
  final String authorName;

  const UserChatScreen({
    Key? key,
    required this.roomChatName,
    required this.authorName,
  }) : super(key: key);

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  IO.Socket? socket;
  List<UserChatDataModel> listMsg = [];

  // UserChatModel? userChatModel;

  @override
  void initState() {
    super.initState();

    connect();
    getDataAPI();
  }

  void getDataAPI() {
    DioHelper.getData(url: getChatEndPoint).then((value) {
      log(value.data.toString());
      // userChatModel = UserChatModel.fromJson(value.data);

      for (var element in value.data) {
        for (var element2 in element['data']) {
          listMsg.add(UserChatDataModel.fromJson(element2));
        }
      }

      setState(() {
        listMsg;
      });
    }).catchError((error) {
      log('getDataAPI Error=${error.toString()}');
    });
  }

  void sendDataAPI(String message) {
    DioHelper.postData(
      url: sendChatEndPoint,
      data: {
        'room': widget.roomChatName,
        'data': {
          'room': widget.roomChatName,
          'author': widget.authorName,
          'message': message,
          'messageType': 'message',
          'see': [widget.authorName, 'mm@gmail.com'],
          'time': "6:56",
        },
      },
    ).then((value) {
      log('Send Data=${value.data}');
    }).catchError((error) {
      log('Error=${error.toString()}');
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  void connect() {
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
    // Dart client
    socket = IO.io('http://192.168.1.17:3001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect(); // connect frontend to backend
    print('We are here!');

    socket!.onConnect((_) {
      print('Connected into frontend!');
      // receive data from backend to frontend

      socket!.on('receive_message', (data) {
        print('receive_message from backend: $data');

        if (data['author'] != widget.authorName) {
          setState(() {
            listMsg.add(UserChatDataModel(
              room: data['room'],
              sender: data['author'],
              message: data['message'],
              messageType: data['messageType'],
              // see: data['see'],
              // time: data['time'],
              // id: data['_id'],
            ));
          });
        }
      });

      //
    });

    socket!.onConnectError((data) => print('Connect Error: $data'));
    socket!.onDisconnect((data) => print('Socket.IO server disconnected'));
  }

  void sendMsg(String msg) {
    // Send data from frontend to backend

    UserChatDataModel ownMsg = UserChatDataModel(
      room: widget.roomChatName,
      sender: widget.authorName,
      message: msg,
      messageType: 'message',
      // see: ['ali@gmail.com', 'mm@gmail.com'],
      // time: "6:56",
    );

    listMsg.add(ownMsg);
    setState(() {
      listMsg;
    });

    socket!.emit('send_message', {
      'room': widget.roomChatName,
      'author': widget.authorName,
      'message': msg,
      'messageType': 'message',
      'see': [widget.authorName, 'mm@gmail.com'],
      'time': "6:56"
    });

    sendDataAPI(msg);
  }

  @override
  Widget build(BuildContext context) {
    print('UserChatScreen');
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: myDefaultPadding,
              ),
              child: ListView.builder(
                reverse: true,
                controller: _scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                // shrinkWrap: true,
                // reverse: true,
                physics: const BouncingScrollPhysics(),
                itemCount: listMsg.length,
                itemBuilder: (context, index) {
                  // if (index == listMsg.length) {
                  //   return Container(height: 80.0);
                  // }

                  return message(listMsg.reversed.toList()[index]);
                },
              ),
            ),
          ),
          myInputField(),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          const CircleAvatar(
              // backgroundImage: AssetImage('assets/images/user_2.png'),
              ),
          const SizedBox(width: myDefaultPadding * 0.75),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.roomChatName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16.0),
                ),
                const Text(
                  'Active 3m ago',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.local_phone),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.videocam),
        ),
        const SizedBox(width: myDefaultPadding / 2),
      ],
    );
  }

  Widget myInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: myDefaultPadding,
        vertical: myDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0.0, 4.0),
            blurRadius: 32.0,
            color: const Color(0xFF087949).withOpacity(0.2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(
              Icons.mic,
              color: MyColors.myPrimaryColor,
            ),
            const SizedBox(width: myDefaultPadding),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: myDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: MyColors.myPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.64),
                    ),
                    const SizedBox(width: myDefaultPadding / 4),
                    Expanded(
                      child: TextFormField(
                        onTap: () {
                          // _scrollController.animateTo(
                          //   _scrollController.position.maxScrollExtent,
                          //   duration: const Duration(milliseconds: 300),
                          //   curve: Curves.easeOut,
                          // );
                        },
                        autofocus: true,
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.64),
                    ),
                    const SizedBox(width: myDefaultPadding / 4),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.64),
                    ),
                    const SizedBox(width: myDefaultPadding / 4),
                    IconButton(
                      onPressed: () {
                        // _scrollController.animateTo(
                        //   _scrollController.position.maxScrollExtent,
                        //   duration: const Duration(milliseconds: 300),
                        //   curve: Curves.easeOut,
                        // );

                        String msg = _messageController.text.trim();
                        if (msg.isNotEmpty) {
                          print(msg);
                          // setState(() {
                          sendMsg(msg);
                          _messageController.clear();
                          // _messageController.text = '';
                          // });
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: MyColors.myPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget message(UserChatDataModel model) {
    // _scrollController.animateTo(
    //   _scrollController.position.maxScrollExtent,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeOut,
    // );
    return Padding(
      padding: const EdgeInsets.only(
        top: myDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment: model.sender == widget.authorName
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (model.sender != widget.authorName) ...[
            // Used to add list to the current list
            const CircleAvatar(
              radius: 12.0,
              // backgroundImage: AssetImage('assets/images/user_2.png'),
            ),
            const SizedBox(width: myDefaultPadding / 2),
          ],
          textMessage(model),
          // messageContent(message),
          // if (message.isSender) MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }

  Widget textMessage(UserChatDataModel model) {
    // log('log me', name: 'my.app.category');

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(
        horizontal: myDefaultPadding * 0.75,
        vertical: myDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: MyColors.myPrimaryColor
            .withOpacity(model.sender == widget.authorName ? 1.0 : 0.08),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(
        model.message,
        style: TextStyle(
          color: model.sender == widget.authorName
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1?.color,
        ),
      ),
    );
  }
}
