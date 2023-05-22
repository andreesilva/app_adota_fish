class PhotoDonationRequestModel {
  int? id;
  String? photo;

  PhotoDonationRequestModel({
    required this.photo,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'foto': photo,
      };
}
