class PetNotPhotoRequestModel {
  int? id;
  int specie;
  int amount;
  String? observation;

  PetNotPhotoRequestModel({
    this.id,
    required this.specie,
    required this.amount,
    this.observation,
  });

  Map<String, dynamic> toJson() => {
        'especie_id': specie,
        'quantidade': amount,
        if (observation!.isNotEmpty) 'observacao': observation
      };
}
