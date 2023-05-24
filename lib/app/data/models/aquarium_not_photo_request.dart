class AquariumNotPhotoRequestModel {
  int? id;

  int capacity;
  String? description;

  AquariumNotPhotoRequestModel({
    this.id,
    required this.capacity,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'capacidade': capacity,
        if (description!.isNotEmpty) 'descricao': description
      };
}
