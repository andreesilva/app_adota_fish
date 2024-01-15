import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/myDonationsAquarium/controller.dart';
import 'package:app_adota_fish/app/modules/myDonationsAquarium/repository.dart';

import 'package:get/get.dart';

class MyDonationsAquariumBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyDonationsAquariumController>(() =>
        MyDonationsAquariumController(
            MyDonationsAquariumRepository(Get.find<Api>())));
  }
}
