enum ChatMessageType { text, audio, image, video }

enum MessageStatus { notSent, notView, viewed }

class ChatMessageModel {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessageModel({
    this.text = '',
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });
}

List<ChatMessageModel> demoChatMessages = [
  ChatMessageModel(
    text: "Hi Sajol,",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessageModel(
    text: "Hello, How are you?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessageModel(
    text: "",
    messageType: ChatMessageType.audio,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessageModel(
    text: "",
    messageType: ChatMessageType.audio,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessageModel(
    text: "",
    messageType: ChatMessageType.video,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessageModel(
    text: "Error happened",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.notSent,
    isSender: true,
  ),
  ChatMessageModel(
    text: "This looks great man!!",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessageModel(
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.notView,
    isSender: true,
  ),
];
