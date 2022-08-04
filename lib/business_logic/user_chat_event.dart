part of 'user_chat_bloc.dart';

abstract class UserChatEvent extends Equatable {
  const UserChatEvent();

  @override
  List<Object?> get props => [];
}

class AddUserChatEvent extends UserChatEvent {
  final ChatModel chat;
  const AddUserChatEvent({required this.chat});

  @override
  List<Object?> get props => [chat];
}
