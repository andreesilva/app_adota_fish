import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/photo_client/controller.dart';
import 'package:app_adota_fish/app/modules/photo_client/repository.dart';
import 'package:get/get.dart';

class PhotoClientBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoClientController>(
        () => PhotoClientController(PhotoClientRepository(Get.find<Api>())));
  }
}
