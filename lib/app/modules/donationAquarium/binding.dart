import 'package:app_adota_fish/app/modules/donationAquarium/controller.dart';
import 'package:app_adota_fish/app/modules/donationAquarium/repository.dart';
import 'package:get/get.dart';

import '../../data/providers/api.dart';

class DonationAquariumBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonationAquariumController>(() => DonationAquariumController(
        DonationAquariumRepository(Get.find<Api>())));
  }
}
