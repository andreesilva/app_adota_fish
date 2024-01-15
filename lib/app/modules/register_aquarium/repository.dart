import 'package:app_adota_fish/app/data/models/aquarium.dart';
import 'package:app_adota_fish/app/data/models/aquarium_request.dart';
import 'package:app_adota_fish/app/data/models/city_full.dart';
import 'package:app_adota_fish/app/data/models/user_address_request.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class RegisterAquariumRepository {
  final Api _api;

  RegisterAquariumRepository(this._api);

  Future<List<CityFullModel>> getCitiesState(int id) => _api.getCitiesState(id);

  Future<AquariumModel> register(AquariumRequestModel aquariumRequestModel) =>
      _api.registerAquarium(aquariumRequestModel);

  Future<void> postAddress(UserAddressRequestModel userAddressRequest) =>
      _api.postAddress(userAddressRequest);
}
