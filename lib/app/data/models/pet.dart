import 'package:app_adota_fish/app/data/models/specie.dart';

class PetModel {
  //int id;
  String? photo;
  int? amount;
  String? observation;
  SpecieModel? specie;

  PetModel({
    //required this.id,
    required this.photo,
    required this.amount,
    this.observation,
    required this.specie,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
      //id: json['id'],
      photo: json['foto'],
      amount: json['quantidade'],
      observation: json['observacao'],
      specie: json['especie'] != null
          ? SpecieModel.fromJson(json['especie'])
          : null);
}
