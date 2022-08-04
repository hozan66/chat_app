import 'package:equatable/equatable.dart';

import '../network/models/chat_model.dart';
import 'bloc_exports.dart';

part 'user_chat_event.dart';
part 'user_chat_state.dart';

class UserChatBloc extends HydratedBloc<UserChatEvent, UserChatState> {
  UserChatBloc() : super(const UserChatState()) {
    on<AddUserChatEvent>(_onAddUserChat);
  }

  void _onAddUserChat(AddUserChatEvent event, Emitter<UserChatState> emit) {
    final state = this.state;
    emit(UserChatState(
      chatsList: List.from(state.chatsList)
        ..add(event.chat), // Adding model to the list
    ));
  }

  @override
  // To Retrieve Data
  UserChatState? fromJson(Map<String, dynamic> json) {
    return UserChatState.fromMap(json);
  }

  @override
  // To Save Data
  Map<String, dynamic>? toJson(UserChatState state) {
    return state.toMap();
  }
}
