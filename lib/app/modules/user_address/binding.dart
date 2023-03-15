import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/user_address/controller.dart';
import 'package:app_adota_fish/app/modules/user_address/repository.dart';
import 'package:get/get.dart';

class UserAddressBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<UserAddressController>(() => UserAddressController(
    UserAddressRepository(Get.find<Api>())
    ));
  }
}