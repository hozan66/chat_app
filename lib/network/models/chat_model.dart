import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String name, lastMessage, image, time;
  final bool isActive;

  const ChatModel({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastMessage': lastMessage,
      'image': image,
      'time': time,
      'isActive': isActive,
    };
  }

  // We use the factory keyword to implement constructors
  // that do not produce new instances of an existing class.
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      name: map['name'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      image: map['image'] ?? '',
      time: map['time'] ?? '',
      isActive: map['isActive'],
    );
  }

  @override
  List<Object?> get props => [name, lastMessage, image, time, isActive];
}

List<ChatModel> chatsData = [
  // ChatModel(
  //   name: "Jenny Wilson",
  //   lastMessage: "Hope you are doing well...",
  //   image: "assets/images/user.png",
  //   time: "3m ago",
  //   isActive: false,
  // ),
  // ChatModel(
  //   name: "Esther Howard",
  //   lastMessage: "Hello Abdullah! I am...",
  //   image: "assets/images/user_2.png",
  //   time: "8m ago",
  //   isActive: true,
  // ),
  // ChatModel(
  //   name: "Ralph Edwards",
  //   lastMessage: "Do you have update...",
  //   image: "assets/images/user_3.png",
  //   time: "5d ago",
  //   isActive: false,
  // ),
  // ChatModel(
  //   name: "Jacob Jones",
  //   lastMessage: "You’re welcome :)",
  //   image: "assets/images/user_4.png",
  //   time: "5d ago",
  //   isActive: true,
  // ),
  // ChatModel(
  //   name: "Albert Flores",
  //   lastMessage: "Thanks",
  //   image: "assets/images/user_5.png",
  //   time: "6d ago",
  //   isActive: false,
  // ),
  // ChatModel(
  //   name: "Jenny Wilson",
  //   lastMessage: "Hope you are doing well...",
  //   image: "assets/images/user.png",
  //   time: "3m ago",
  //   isActive: false,
  // ),
  // ChatModel(
  //   name: "Esther Howard",
  //   lastMessage: "Hello Abdullah! I am...",
  //   image: "assets/images/user_2.png",
  //   time: "8m ago",
  //   isActive: true,
  // ),
  // ChatModel(
  //   name: "Ralph Edwards",
  //   lastMessage: "Do you have update...",
  //   image: "assets/images/user_3.png",
  //   time: "5d ago",
  //   isActive: false,
  // ),
];
