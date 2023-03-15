import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/register_pet/controller.dart';
import 'package:app_adota_fish/app/modules/register_pet/repository.dart';
import 'package:get/get.dart';

class RegisterPetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterPetController>(
        () => RegisterPetController(RegistePetRepository(Get.find<Api>())));
  }
}
