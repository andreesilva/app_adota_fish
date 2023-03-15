import 'package:app_adota_fish/app/data/models/city.dart';

class AddressModel {
  int id;
  String street;
  String number;
  String neighborhood;
  String? referencePoint;
  String? complement;
  CityModel city;

  AddressModel({
    required this.id,
    required this.street,
    required this.number,
    required this.neighborhood,
    this.referencePoint,
    this.complement,
    required this.city,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
      id: json['id'],
      street: json['rua'],
      number: json['numero'],
      neighborhood: json['bairro'],
      referencePoint: json['ponto_referencia'],
      complement: json['complemento'],
      city: CityModel.from(json['cidade']));
}
