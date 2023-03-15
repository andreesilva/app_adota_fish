import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/myDonationsPet/controller.dart';
import 'package:app_adota_fish/app/modules/myDonationsPet/repository.dart';

import 'package:get/get.dart';

class MyDonationsPetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyDonationsPetController>(() =>
        MyDonationsPetController(MyDonationsPetRepository(Get.find<Api>())));
  }
}
