import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class AllDonationPetRepository {
  final Api _api;

  AllDonationPetRepository(this._api);

  Future<List<DonationPetModel>> getDonationsPets() => _api.getDonationsPet();
}
