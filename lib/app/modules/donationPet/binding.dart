import 'package:app_adota_fish/app/modules/donationPet/controller.dart';
import 'package:app_adota_fish/app/modules/donationPet/repository.dart';
import 'package:get/get.dart';

import '../../data/providers/api.dart';

class DonationPetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonationPetController>(
        () => DonationPetController(DonationPetRepository(Get.find<Api>())));
  }
}
