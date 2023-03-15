import 'package:app_adota_fish/app/data/models/user.dart';
import 'package:app_adota_fish/app/data/models/user_profile_request.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class OptionDonationRepository {
  final Api _api;

  OptionDonationRepository(this._api);

  Future<UserModel> getUser() => _api.getUser();

  Future<UserModel> putUser(UserProfileRequestModel userProfileRequest) =>
      _api.putUser(userProfileRequest);
}
