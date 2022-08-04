part of 'user_chat_bloc.dart';

class UserChatState extends Equatable {
  final List<ChatModel> chatsList;

  const UserChatState({this.chatsList = const []});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'chatsList': chatsList.map((x) => x.toMap()).toList()});

    return result;
  }

  factory UserChatState.fromMap(Map<String, dynamic> map) {
    return UserChatState(
      chatsList: List<ChatModel>.from(
          map['chatsList']?.map((x) => ChatModel.fromMap(x))),
    );
  }

  @override
  List<Object?> get props => [chatsList];
}
