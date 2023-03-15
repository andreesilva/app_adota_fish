

class UserLoginResponseModel {
  String token;
  String expireAt;

  UserLoginResponseModel({required this.token, required this.expireAt});

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseModel(token: json['token'], expireAt: json['expires_at']);

}
