class StateModel {
  int id;
  String name;
  String uf;

  StateModel({
    required this.id,
    required this.name,
    required this.uf,
  });

  factory StateModel.from(Map<String, dynamic> json) =>
      StateModel(id: json['id'], name: json['nome'], uf: json['uf']);
}
