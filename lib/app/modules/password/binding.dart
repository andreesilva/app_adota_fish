import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/password/controller.dart';
import 'package:app_adota_fish/app/modules/password/repository.dart';
import 'package:get/get.dart';

class PasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordController>(
        () => PasswordController(PasswordRepository(Get.find<Api>())));
  }
}
