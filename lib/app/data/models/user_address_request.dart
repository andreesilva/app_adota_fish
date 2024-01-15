class UserAddressRequestModel {
  int? id;
  int clientId;
  String street;
  String number;
  String neighborhood;
  String? referencePoint;
  String? complement;
  int cityId;

  UserAddressRequestModel(
      {this.id,
      required this.clientId,
      required this.street,
      required this.number,
      required this.neighborhood,
      this.referencePoint,
      this.complement,
      required this.cityId});

  Map<String, dynamic> toJson() => {
        'cliente_id': clientId,
        'rua': street,
        'numero': number,
        'bairro': neighborhood,
        if (referencePoint!.isNotEmpty) 'ponto_referencia': referencePoint,
        'cidade_id': cityId,
        if (complement!.isNotEmpty) 'complemento': complement
      };
}
