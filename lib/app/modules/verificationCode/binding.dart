import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/verificationCode/controller.dart';
import 'package:app_adota_fish/app/modules/verificationCode/repository.dart';
import 'package:get/get.dart';

class VerificationCodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationCodeController>(() => VerificationCodeController(
        VerificationCodeRepository(Get.find<Api>())));
  }
}
