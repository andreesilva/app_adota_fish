import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/resetPassword/controller.dart';
import 'package:app_adota_fish/app/modules/resetPassword/repository.dart';
import 'package:get/get.dart';

class ResetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() =>
        ResetPasswordController(ResetPasswordRepository(Get.find<Api>())));
  }
}
