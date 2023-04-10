import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/account/controller.dart';
import 'package:app_adota_fish/app/modules/account/repository.dart';
import 'package:app_adota_fish/app/modules/dashboard/controller_aquarium.dart';
import 'package:app_adota_fish/app/modules/myDonationsAquarium/repository.dart';
import 'package:app_adota_fish/app/modules/allDonationPet/controller.dart';
import 'package:app_adota_fish/app/modules/allDonationPet/repository.dart';
import 'package:app_adota_fish/app/modules/dashboard/controller.dart';
import 'package:app_adota_fish/app/modules/home/controller.dart';
import 'package:app_adota_fish/app/modules/home/repository.dart';
import 'package:app_adota_fish/app/modules/login/controller.dart';
import 'package:app_adota_fish/app/modules/option_donation/controller.dart';
import 'package:app_adota_fish/app/modules/password/controller.dart';
import 'package:app_adota_fish/app/modules/password/repository.dart';
import 'package:app_adota_fish/app/modules/user_profile/controller.dart';
import 'package:app_adota_fish/app/modules/user_profile/repository.dart';
import 'package:get/get.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<DashboardAquariumController>(() => DashboardAquariumController());
    Get.lazyPut<HomeController>(
        () => HomeController(HomeRepository(Get.find<Api>())));
    Get.lazyPut<AllDonationPetController>(() =>
        AllDonationPetController(AllDonationPetRepository(Get.find<Api>())));
    Get.lazyPut<AccountController>(
        () => AccountController(AccountRepository(Get.find<Api>())));
    Get.lazyPut<UserProfileController>(
        () => UserProfileController(UserProfileRepository(Get.find<Api>())));
    Get.lazyPut<PasswordController>(
        () => PasswordController(PasswordRepository(Get.find<Api>())));
    Get.lazyPut<LoginController>(() => LoginController());

    Get.lazyPut<OptionDonationController>(() => OptionDonationController());
  }
}
