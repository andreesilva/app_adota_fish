import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/register/controller.dart';
import 'package:app_adota_fish/app/modules/register/repository.dart';
import 'package:get/get.dart';

class RegisterBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController(RegisterRepository(Get.find<Api>())));
  }
}
