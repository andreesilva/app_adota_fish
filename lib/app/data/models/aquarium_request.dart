class AquariumRequestModel {
  int? id;
  String photo;
  int capacity;
  String? description;

  AquariumRequestModel({
    this.id,
    required this.photo,
    required this.capacity,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'foto': photo,
        'capacidade': capacity,
        if (description!.isNotEmpty) 'descricao': description
      };
}
