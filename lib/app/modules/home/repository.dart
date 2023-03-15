import 'package:app_adota_fish/app/data/models/donations_aquarium.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class HomeRepository {
  final Api _api;

  HomeRepository(this._api);

  Future<List<DonationAquariumModel>> getDonations() =>
      _api.getDonationsAquarium();
}
