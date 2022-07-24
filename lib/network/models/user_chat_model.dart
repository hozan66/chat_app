class UserChatModel {
  late String status;
  late List<UserChatDataModel> dataModel;

  UserChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    json['data'].forEach((element) {
      dataModel.add(UserChatDataModel.fromJson(element));
    });
  }
}

class UserChatDataModel {
  late String id;
  late String room;
  late String sender;
  late String message;

  UserChatDataModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    room = json['room'];
    sender = json['author'];
    message = json['message'];
  }
}
