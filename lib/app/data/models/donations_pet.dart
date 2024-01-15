import 'package:app_adota_fish/app/data/models/client.dart';
import 'package:app_adota_fish/app/data/models/pet.dart';

class DonationPetModel {
  int id;
  ClientModel clientDonor;
  ClientModel? clientAdopter;
  PetModel pet;
  int status;
  DateTime createdAt;
  int petId;

  DonationPetModel(
      {required this.id,
      required this.clientDonor,
      this.clientAdopter,
      required this.pet,
      required this.status,
      required this.createdAt,
      required this.petId});

  factory DonationPetModel.fromJson(Map<String, dynamic> json) =>
      DonationPetModel(
        id: json['id'],
        clientDonor: ClientModel.fromJson(json['cliente_doador']),
        clientAdopter: json['cliente_adotante'] != null
            ? ClientModel.fromJson(json['cliente_adotante'])
            : null,
        pet: PetModel.fromJson(json['pet']),
        status: json['status'],
        createdAt: DateTime.parse(json['created_at']),
        petId: json['pet_id'],
      );
}
