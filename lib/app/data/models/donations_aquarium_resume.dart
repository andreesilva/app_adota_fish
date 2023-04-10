import 'package:app_adota_fish/app/data/models/aquarium.dart';
import 'package:app_adota_fish/app/data/models/client.dart';

class DonationAquariumResumeModel {
  int id;
  String photo;
  int capacity;
  String nome;

  DonationAquariumResumeModel(
      {required this.id,
      required this.photo,
      required this.capacity,
      required this.nome,});

  factory DonationAquariumResumeModel.fromJson(Map<String, dynamic> json) =>
      DonationAquariumResumeModel(
          id: json['id'],
          photo: json['foto'],
          capacity: json['capacidade'],
          nome: json['nome'],
          );
}