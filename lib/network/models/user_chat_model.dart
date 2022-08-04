class UserChatModel {
  late String status;
  late List<UserChatDataModel> dataModel;

  UserChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    json['data'].forEach((element) {
      dataModel.add(UserChatDataModel.fromJson(element));
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': dataModel.map((x) => x.toJson()).toList(),
    };
  }
}

class UserChatDataModel {
  late String room;
  late String sender;
  late String message;
  late String messageType;
  // late List see;
  // late String time;
  // late String id;

  UserChatDataModel({
    required this.room,
    required this.sender,
    required this.message,
    required this.messageType,
    // this.see = const [],
    // this.time = '12:12',
    // this.id = '',
  });

  UserChatDataModel.fromJson(Map<String, dynamic> json) {
    room = json['room'];
    sender = json['author'];
    message = json['message'];
    messageType = json['messageType'];
    // see = json['see'] ?? [];
    // time = json['time'] ?? '12:12';
    // id = json['_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'room': room,
      'author': sender,
      'message': message,
      'messageType': messageType,
      // 'see': see,
      // 'time': time,
      // '_id': id,
    };
  }
}
