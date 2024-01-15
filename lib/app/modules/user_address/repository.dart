import 'package:app_adota_fish/app/data/models/city_full.dart';
import 'package:app_adota_fish/app/data/models/client.dart';
import 'package:app_adota_fish/app/data/models/user.dart';
import 'package:app_adota_fish/app/data/models/user_address_request.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class UserAddressRepository {
  final Api _api;

  UserAddressRepository(this._api);

  Future<UserModel> getUser() => _api.getUser();

  Future<ClientModel> getClient(int id) => _api.getClient(id);

  Future<List<CityFullModel>> getCitiesState(int id) => _api.getCitiesState(id);

  Future<void> postAddress(UserAddressRequestModel userAddressRequest) =>
      _api.postAddress(userAddressRequest);

  Future<void> putAddress(UserAddressRequestModel userAddressRequest) =>
      _api.putAddress(userAddressRequest);
}
