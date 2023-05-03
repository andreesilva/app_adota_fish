import 'package:app_adota_fish/app/data/models/donations_aquarium.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/donationAquarium/repository.dart';
import 'package:get/get.dart';

class DonationAquariumController extends GetxController
    with StateMixin<DonationAquariumModel> {
  final DonationAquariumRepository _repository;
  final _authService = Get.find<AuthService>();

  DonationAquariumController(this._repository);
  bool get isLogged => _authService.isLogged;

  final loading = true.obs;

  @override
  void onInit() {

    loading(true);

    int id = int.parse(Get.parameters['id']!);

    _repository.getDonationAquarium(id).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
    super.onInit();
  }
}
