class SignUpModel {
  late String status;
  late SignUpData data;

  SignUpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = SignUpData.fromJson(json['data']);
  }
}

class SignUpData {
  late String accessToken;

  SignUpData.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
  }
}
