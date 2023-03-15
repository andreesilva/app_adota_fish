import 'package:app_adota_fish/app/data/models/aquarium.dart';
import 'package:app_adota_fish/app/data/models/client.dart';

class DonationAquariumModel {
  int id;
  ClientModel clientDonor;
  ClientModel? clientAdopter;
  AquariumModel aquarium;
  int status;

  DonationAquariumModel(
      {required this.id,
      required this.clientDonor,
      this.clientAdopter,
      required this.aquarium,
      required this.status});

  factory DonationAquariumModel.fromJson(Map<String, dynamic> json) =>
      DonationAquariumModel(
          id: json['id'],
          clientDonor: ClientModel.fromJson(json['cliente_doador']),
          clientAdopter: json['cliente_adotante'] != null
              ? ClientModel.fromJson(json['cliente_adotante'])
              : null,
          aquarium: AquariumModel.fromJson(json['aquario']),
          status: json['status']);
}
