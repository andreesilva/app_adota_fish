import 'package:app_adota_fish/app/data/models/password.dart';
import 'package:app_adota_fish/app/data/models/user.dart';
import 'package:app_adota_fish/app/data/models/user_profile_request.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class PasswordRepository {
  final Api _api;

  PasswordRepository(this._api);

  Future<UserModel> getUser() => _api.getUser();

  Future<UserModel> putUser(UserProfileRequestModel userProfileRequest) =>
      _api.putUser(userProfileRequest);

/*
  Future<PasswordModel> putPassword(PasswordModel password) =>
      _api.putPassword(password);
      */

  Future<void> putPassword(PasswordModel password) =>
      _api.putPassword(password);
}
