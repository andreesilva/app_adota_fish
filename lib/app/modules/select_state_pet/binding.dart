import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/select_state_pet/controller.dart';
import 'package:app_adota_fish/app/modules/select_state_pet/repository.dart';
import 'package:get/get.dart';

class SelectStatePetBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<SelectStatePetController>(() => SelectStatePetController(SelectStatePetRepository(Get.find<Api>())));
  }
}