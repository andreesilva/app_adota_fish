class SpecieModel {
  int? id;
  String name;
  //int? typeWater;

  SpecieModel({
    this.id,
    required this.name,
    //required this.typeWater,
  });

  factory SpecieModel.fromJson(Map<String, dynamic> json) => SpecieModel(
        id: json['id'],
        name: json['nome'],
        //  typeWater: json['tipo_agua'],
      );
}
