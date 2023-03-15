import 'package:app_adota_fish/app/data/models/donations_aquarium.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class DonationAquariumRepository {
  final Api _api;

  DonationAquariumRepository(this._api);

  Future<DonationAquariumModel> getDonationAquarium(int id) =>
      _api.getDonationAquarium(id);

  Future<List<DonationAquariumModel>> getDonations() =>
      _api.getDonationsAquarium();
}
