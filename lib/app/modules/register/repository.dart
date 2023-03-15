import 'package:app_adota_fish/app/data/models/city_full.dart';
import 'package:app_adota_fish/app/data/models/user.dart';
import 'package:app_adota_fish/app/data/models/user_address_request.dart';
import 'package:app_adota_fish/app/data/models/user_profile_request.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class RegisterRepository {
  final Api _api;

  RegisterRepository(this._api);

  Future<List<CityFullModel>> getCitiesState(int id) => _api.getCitiesState(id);

  Future<UserModel> register(UserProfileRequestModel userProfileRequest) =>
      _api.register(userProfileRequest);

  Future<void> postAddress(UserAddressRequestModel userAddressRequest) =>
      _api.postAddress(userAddressRequest);
}
