import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/register_aquarium/controller.dart';
import 'package:app_adota_fish/app/modules/register_aquarium/repository.dart';
import 'package:get/get.dart';

class RegisterAquariumBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterAquariumController>(() => RegisterAquariumController(
        RegisterAquariumRepository(Get.find<Api>())));
  }
}
