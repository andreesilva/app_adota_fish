import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class MyDonationsPetRepository {
  final Api _api;

  MyDonationsPetRepository(this._api);

  Future<List<DonationPetModel>> getMyDonationsPet() =>
      _api.getMyDonationsPet();

  Future<void> putPetInactivate(int id) => _api.putPetInactivate(id);

  Future<void> putActivatePet(int id) => _api.putActivatePet(id);

  Future<void> deletePet(int id) => _api.deletePet(id);
}
