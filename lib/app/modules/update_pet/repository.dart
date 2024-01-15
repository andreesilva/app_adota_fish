import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/models/pet_not_photo_request.dart';
import 'package:app_adota_fish/app/data/models/photo_client_request.dart';
import 'package:app_adota_fish/app/data/models/specie_request.dart';
import 'package:app_adota_fish/app/data/models/pet.dart';
import 'package:app_adota_fish/app/data/models/pet_request.dart';
import 'package:app_adota_fish/app/data/models/specie.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

import '../../data/models/photo_donation_request.dart';

class UpdatePetRepository {
  final Api _api;

  UpdatePetRepository(this._api);

  Future<DonationPetModel> getDonationPet(int id) => _api.getDonationPet(id);

  Future<List<SpecieModel>> getSpecies(int id) => _api.getSpecies(id);

  Future<PetModel> register(PetRequestModel petRequestModel) =>
      _api.registerPet(petRequestModel);

  Future<SpecieModel> getSpecie(SpecieRequestModel specieRequestModel) =>
      _api.getSpecie(specieRequestModel);

  Future<void> putPhotoPet(
          PhotoDonationRequestModel photoDonationRequestModel) =>
      _api.putPhotoPet(photoDonationRequestModel);
  Future<void> putPet(PetNotPhotoRequestModel petNotPhotoRequestModel) =>
      _api.putPet(petNotPhotoRequestModel);
}
