import 'package:app_adota_fish/app/data/models/state.dart';

class CityFullModel {
  int id;
  String name;
  int idState;

  CityFullModel({
    required this.id,
    required this.name,
    required this.idState,
  });

  factory CityFullModel.from(Map<String, dynamic> json) => CityFullModel(
        id: json['id'],
        name: json['nome'],
        idState: json['estado_id'],
      );
}
