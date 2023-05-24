import 'package:app_adota_fish/app/data/models/aquarium_not_photo_request.dart';
import 'package:app_adota_fish/app/data/models/donations_aquarium.dart';
import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/models/pet_not_photo_request.dart';
import 'package:app_adota_fish/app/data/models/photo_client_request.dart';
import 'package:app_adota_fish/app/data/models/specie_request.dart';
import 'package:app_adota_fish/app/data/models/pet.dart';
import 'package:app_adota_fish/app/data/models/pet_request.dart';
import 'package:app_adota_fish/app/data/models/specie.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

import '../../data/models/photo_donation_request.dart';

class UpdateAquariumRepository {
  final Api _api;

  UpdateAquariumRepository(this._api);

  Future<DonationAquariumModel> getDonationAquarium(int id) =>
      _api.getDonationAquarium(id);

  Future<void> putPhotoAquarium(
          PhotoDonationRequestModel photoDonationRequestModel) =>
      _api.putPhotoAquarium(photoDonationRequestModel);

  Future<void> putAquarium(
          AquariumNotPhotoRequestModel aquariumNotPhotoRequestModel) =>
      _api.putAquarium(aquariumNotPhotoRequestModel);
}
