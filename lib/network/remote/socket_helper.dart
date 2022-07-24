// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// import '../../shared/constants/strings.dart';
// import '../models/message_model.dart';
//
// class SocketHelper {
//   static IO.Socket? socket;
//
//   // static List<MessageModel> listMsg = [];
//
//   static void connect() {
//     //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
//     // Dart client
//     socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });
//
//     socket!.connect(); // connect frontend to backend
//     print('We are here!');
//
//     socket!.onConnect((_) {
//       print('Connected into frontend!');
//
//       receiveMessage();
//     });
//
//     socket!.onConnectError((data) => print('Connect Error: $data'));
//     socket!.onDisconnect((data) => print('Socket.IO server disconnected'));
//   }
//
//   static MessageModel sendMessage(String msg) {
//     // Send data from frontend to backend
//
//     MessageModel ownMsg = MessageModel(
//       room: 'room_chat',
//       type: 'ownMsg',
//       msg: msg,
//       sender: token ?? 'sender',
//     );
//     // UserChatCubit.getMessages(ownMsg);
//     // listMsg.add(ownMsg);
//     socket!.emit('send_message', {
//       'room': 'room_chat',
//       'type': 'ownMsg',
//       'msg': msg,
//       'sender': token,
//     });
//
//     return ownMsg;
//   }
//
//   static MessageModel? receiveMessage() {
//     // receive data from backend to frontend
//     MessageModel? otherMsg;
//
//     socket!.on('receive_message', (data) {
//       print('receive_message from backend: $data');
//
//       otherMsg = MessageModel(
//         room: data['room'],
//         type: data['type'],
//         msg: data['msg'],
//         sender: data['sender'],
//       );
//       // listMsg.add(otherMsg);
//     });
//
//     return otherMsg;
//   }
// }
