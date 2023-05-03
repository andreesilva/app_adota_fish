import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/allDonationPet/controller.dart';
import 'package:app_adota_fish/app/modules/allDonationPet/repository.dart';
import 'package:app_adota_fish/app/modules/dashboard/controller_pet.dart';
import 'package:app_adota_fish/app/modules/splash/controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
