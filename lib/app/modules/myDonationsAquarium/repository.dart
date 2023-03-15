import 'package:app_adota_fish/app/data/models/donations_aquarium.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class MyDonationsAquariumRepository {
  final Api _api;

  MyDonationsAquariumRepository(this._api);

  Future<List<DonationAquariumModel>> getMyDonationsAquarium() =>
      _api.getMyDonationsAquarium();

  Future<void> putAquariumInactivate(int id) => _api.putAquariumInactivate(id);

  Future<void> putActivateAquarium(int id) => _api.putActivateAquarium(id);

  Future<void> deleteAquarium(int id) => _api.deleteAquarium(id);
}
