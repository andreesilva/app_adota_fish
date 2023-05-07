class CityRequestModel {
  //int? id;
  String name;

  CityRequestModel({
    //this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => {'nome': name};
}
