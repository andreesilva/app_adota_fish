class PasswordModel {
  String? password;
  String? email;

  PasswordModel({
    required this.password,
    this.email,
  });

  Map<String, dynamic> toJson() => {
        'password': password,
        'email': email,
      };
}
