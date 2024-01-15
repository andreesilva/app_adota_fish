class Photo {
  String? id = "0";
  int? occurrencesServiceId = 0;
  String? name;
  String? filepath;
  String? fileType;
  String? firebaseRef;
  String? description;
  String? size;
  bool isUploading;

  Photo({
    this.id,
    this.occurrencesServiceId,
    this.name,
    this.filepath,
    this.fileType,
    this.firebaseRef,
    this.description,
    this.size,
    this.isUploading = true,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json['id'],
        occurrencesServiceId: json['occurrencesServiceId'],
        name: json['name'],
        filepath: json['filepath'],
        fileType: json['fileType'],
        firebaseRef: json['firebaseRef'],
        description: json['description'],
        size: json['size'],
        isUploading: json['isUploading'],
      );
}
