class SignInModel {
  late String status;
  late String accessToken;

  SignInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['accessToken'];
  }
}
