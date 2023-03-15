import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class DonationPetRepository {
  final Api _api;

  DonationPetRepository(this._api);

  Future<DonationPetModel> getDonationPet(int id) => _api.getDonationPet(id);

  Future<List<DonationPetModel>> getDonations() => _api.getDonationsPet();
}
