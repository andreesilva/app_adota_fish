import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/user_profile/controller.dart';
import 'package:app_adota_fish/app/modules/user_profile/repository.dart';
import 'package:get/get.dart';

class UserProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(
        () => UserProfileController(UserProfileRepository(Get.find<Api>())));
  }
}
