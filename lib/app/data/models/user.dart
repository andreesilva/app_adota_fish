class UserModel {
  int? id;
  String name;
  String email;
  String phone;
  String? photo;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['nome'],
        email: json['email'],
        phone: json['telefone'],
        photo: json['foto'],
      );
}
