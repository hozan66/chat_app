class MessageModel {
  late String room;
  late String type;
  late String msg;
  late String sender;
  late bool isSender;

  MessageModel({
    required this.room,
    required this.type,
    required this.msg,
    required this.sender,
    required this.isSender,
  });
}
