import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/forgotPassword/controller.dart';
import 'package:app_adota_fish/app/modules/forgotPassword/repository.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() =>
        ForgotPasswordController(ForgotPasswordRepository(Get.find<Api>())));
  }
}
