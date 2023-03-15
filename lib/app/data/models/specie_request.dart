class SpecieRequestModel {
  //int? id;
  String name;

  SpecieRequestModel({
    //this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => {'nome': name};
}
