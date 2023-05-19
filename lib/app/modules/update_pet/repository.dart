import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/models/specie_request.dart';
import 'package:app_adota_fish/app/data/models/pet.dart';
import 'package:app_adota_fish/app/data/models/pet_request.dart';
import 'package:app_adota_fish/app/data/models/specie.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class UpdatePetRepository {
  final Api _api;

  UpdatePetRepository(this._api);

  Future<DonationPetModel> getDonationPet(int id) => _api.getDonationPet(id);

  Future<List<SpecieModel>> getSpecies(int id) => _api.getSpecies(id);

  Future<PetModel> register(PetRequestModel petRequestModel) =>
      _api.registerPet(petRequestModel);

  Future<SpecieModel> getSpecie(SpecieRequestModel specieRequestModel) =>
      _api.getSpecie(specieRequestModel);
}
