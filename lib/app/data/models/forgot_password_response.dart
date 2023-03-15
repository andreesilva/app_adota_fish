class ForgotPasswordResponseModel {
  int? id;
  String? name;
  int code;
  String? email;

  ForgotPasswordResponseModel(
      {this.id, required this.name, required this.code, this.email});

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponseModel(
          id: json['id'],
          name: json['nome'],
          code: json['codigo'],
          email: json['email']);
}
