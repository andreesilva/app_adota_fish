class AquariumModel {
  //int id;
  String? photo;
  int? capacity;
  String? description;

  AquariumModel({
    //required this.id,
    required this.photo,
    required this.capacity,
    this.description,
  });

  factory AquariumModel.fromJson(Map<String, dynamic> json) => AquariumModel(
        //  id: json['id'],
        photo: json['foto'],
        capacity: json['capacidade'],
        description: json['descricao'],
      );
}
