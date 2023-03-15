class UserLoginRequestModel {
  int? id;
  String email;
  String password;

  UserLoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() =>
      {'id': id, 'email': email, 'password': password};
}
