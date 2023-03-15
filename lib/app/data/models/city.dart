import 'package:app_adota_fish/app/data/models/state.dart';

class CityModel {
  int id;
  String name;
  int idState;
  StateModel state;

  CityModel({
    required this.id,
    required this.name,
    required this.idState,
    required this.state,
  });

  factory CityModel.from(Map<String, dynamic> json) => CityModel(
      id: json['id'],
      name: json['nome'],
      idState: json['estado_id'],
      state: StateModel.from(json['estado']));
}
