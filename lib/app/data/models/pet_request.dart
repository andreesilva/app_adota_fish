class PetRequestModel {
  int? id;
  String photo;
  int specie;
  int amount;
  String? observation;

  PetRequestModel({
    this.id,
    required this.photo,
    required this.specie,
    required this.amount,
    this.observation,
  });

  Map<String, dynamic> toJson() => {
        'foto': photo,
        'especie_id': specie,
        'quantidade': amount,
        if (observation!.isNotEmpty) 'observacao': observation
      };
}
