import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/donationPet/repository.dart';
import 'package:get/get.dart';

class DonationPetController extends GetxController
    with StateMixin<DonationPetModel> {
  final DonationPetRepository _repository;
  final _authService = Get.find<AuthService>();

  DonationPetController(this._repository);
  bool get isLogged => _authService.isLogged;

  @override
  void onInit() {
    int id = int.parse(Get.parameters['id']!);

    //if (isLogged) {
    print("Msg 1");
    _repository.getDonationPet(id).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
    //}
    super.onInit();
  }
}
