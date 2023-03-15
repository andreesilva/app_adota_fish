class ForgotPasswordRequestModel {
  String email;

  ForgotPasswordRequestModel({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}
