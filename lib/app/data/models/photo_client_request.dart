class PhotoClientRequestModel {
  String? photo;

  PhotoClientRequestModel({
    required this.photo,
  });

  Map<String, dynamic> toJson() => {
        'foto': photo,
      };
}
