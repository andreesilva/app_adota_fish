import 'package:app_adota_fish/app/data/models/photo_client_request.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class PhotoClientRepository {
  final Api _api;

  PhotoClientRepository(this._api);

  Future<void> putPhotoClient(
          PhotoClientRequestModel photoClientRequestModel) =>
      _api.putPhotoClient(photoClientRequestModel);
}
