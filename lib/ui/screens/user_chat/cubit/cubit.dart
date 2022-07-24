// import 'package:chat_app/network/remote/socket_helper.dart';
// import 'package:chat_app/ui/screens/user_chat/cubit/states.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../network/models/message_model.dart';
//
// class UserChatCubit extends Cubit<UserChatStates> {
//   UserChatCubit() : super(UserChatInitialState());
//
//   // Create an object from cubit
//   static UserChatCubit get(context) => BlocProvider.of(context);
//
//   List<MessageModel>? listMsg;
//   void getMessages(String msg) {
//     print('===============getMessages=============');
//     MessageModel? model;
//     model = SocketHelper.sendMessage(msg);
//     listMsg?.add(model);
//
//     model = SocketHelper.receiveMessage();
//     listMsg?.add(model!);
//
//     listMsg?.forEach((element) {
//       print('My message: ${element.msg}');
//     });
//     // emit(UserChatGetMessageState(listMsg));
//   }
// }
