import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:get/get.dart';

class DashboardAquariumController extends GetxController {
  var currentPageIndex = 1.obs;

  final _authService = Get.find<AuthService>();

  @override
  void onInit() {
    int? index = Get.arguments;

    if (index != null) {
      currentPageIndex.value = index;
    }

    super.onInit();
  }

  void changePageIndex(int index) {
    currentPageIndex.value = index;
  }

  bool get isLogged => _authService.isLogged;
}
