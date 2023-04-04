import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/select_state_aquarium/controller.dart';
import 'package:app_adota_fish/app/modules/select_state_aquarium/repository.dart';
import 'package:get/get.dart';

class SelectStateAquariumBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<SelectStateAquariumController>(() => SelectStateAquariumController(SelectStateAquariumRepository(Get.find<Api>())));
  }
}