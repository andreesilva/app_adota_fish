import 'package:app_adota_fish/app/data/models/address.dart';
import 'package:app_adota_fish/app/data/models/user_client.dart';

class ClientModel {
  int id;
  int userId;
  String name;
  String phone;
  String photo;
  UserClientModel user;
  AddressModel address;

  ClientModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.photo,
    required this.user,
    required this.address,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json['id'],
        userId: json['user_id'],
        name: json['nome'],
        phone: json['telefone'],
        photo: json['foto'],
        user: UserClientModel.fromJson(json['usuario']),
        address: AddressModel.fromJson(json['endereco']),
      );
}
