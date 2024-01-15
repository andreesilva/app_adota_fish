class UserClientModel {
  int id;
  String email;

  UserClientModel({
    required this.id,
    required this.email,
  });

  factory UserClientModel.fromJson(Map<String, dynamic> json) =>
      UserClientModel(
        id: json['id'],
        email: json['email'],
      );
}
