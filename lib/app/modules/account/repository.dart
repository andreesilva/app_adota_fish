import 'package:app_adota_fish/app/data/models/photo_client_request.dart';
import 'package:app_adota_fish/app/data/models/user.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class AccountRepository {
  final Api _api;

  AccountRepository(this._api);

  Future<UserModel> getUser() => _api.getUser();

  Future<void> putPhotoClient(
          PhotoClientRequestModel photoClientRequestModel) =>
      _api.putPhotoClient(photoClientRequestModel);
}
