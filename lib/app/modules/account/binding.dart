import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/modules/account/controller.dart';
import 'package:app_adota_fish/app/modules/account/repository.dart';
import 'package:get/get.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(
        () => AccountController(AccountRepository(Get.find<Api>())));
  }
}
