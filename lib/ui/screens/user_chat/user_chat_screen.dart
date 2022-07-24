import 'package:chat_app/network/models/message_model.dart';
import 'package:chat_app/shared/constants/default_values.dart';
import 'package:flutter/material.dart';
import '../../../shared/constants/strings.dart';
import '../../../shared/styles/my_colors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class UserChatScreen extends StatefulWidget {
  final String userId;
  const UserChatScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  final _messageController = TextEditingController();
  IO.Socket? socket;
  List<MessageModel> listMsg = [];

  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void connect() {
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
    // Dart client
    socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
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

        if (data['user_id'] != widget.userId) {
          setState(() {
            listMsg.add(MessageModel(
                room: data['room'],
                type: data['type'],
                msg: data['msg'],
                sender: data['sender'],
                isSender: data['isSender']));
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

    MessageModel ownMsg = MessageModel(
      room: 'room_chat',
      type: 'ownMsg',
      msg: msg,
      sender: token ?? 'sender',
      isSender: true,
    );
    listMsg.add(ownMsg);
    setState(() {
      listMsg;
    });
    socket!.emit('send_message', {
      'room': 'room_chat',
      'type': 'ownMsg',
      'msg': msg,
      'sender': token,
      'isSender': true,
      'user_id': widget.userId,
    });
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
                physics: const BouncingScrollPhysics(),
                itemCount: listMsg.length,
                itemBuilder: (context, index) => message(listMsg[index]),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Room Chat',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Active 3m ago',
                style: TextStyle(fontSize: 12.0),
              ),
            ],
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
                        // autofocus: true,
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

  Widget message(MessageModel model) {
    return Padding(
      padding: const EdgeInsets.only(
        top: myDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment:
            model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!model.isSender) ...[
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

  Widget textMessage(MessageModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: myDefaultPadding * 0.75,
        vertical: myDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: MyColors.myPrimaryColor.withOpacity(model.isSender ? 1.0 : 0.08),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(
        model.msg,
        style: TextStyle(
          color: model.isSender
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1?.color,
        ),
      ),
    );
  }
}
