import 'package:app_adota_fish/app/data/models/aquarium.dart';
import 'package:app_adota_fish/app/data/models/client.dart';
import 'package:app_adota_fish/app/data/models/pet.dart';

class DonationModel {
  int id;
  ClientModel clientDonor;
  ClientModel? clientAdopter;
  int typeDonation;
  PetModel? pet;
  AquariumModel? aquarium;
  int status;

  DonationModel(
      {required this.id,
      required this.clientDonor,
      this.clientAdopter,
      required this.typeDonation,
      required this.pet,
      required this.aquarium,
      required this.status});

  factory DonationModel.fromJson(Map<String, dynamic> json) => DonationModel(
    
      id: json['id'],
      clientDonor:  ClientModel.fromJson(json['cliente_doador']),
      clientAdopter: json['cliente_adotante'] != null
      ? ClientModel.fromJson(json['cliente_adotante'])
      :null,
      typeDonation: json['tipo_doacao'],
      pet: json['pet'] != null
      ? PetModel.fromJson(json['pet'])
      :null,
      aquarium: json['aquarium'] != null
      ? AquariumModel.fromJson(json['aquarium'])
      :null,
      status: json['status']
      );
}