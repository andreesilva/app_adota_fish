import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/select_state/controller.dart';
import 'package:app_adota_fish/app/modules/select_state/repository.dart';
import 'package:get/get.dart';

class SelectStateBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<SelectStateController>(() => SelectStateController(SelectStateRepository(Get.find<Api>())));
  }
}