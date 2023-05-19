import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/donationPet/repository.dart';
import 'package:app_adota_fish/app/widgets/message_general_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';

class DonationPetController extends GetxController
    with StateMixin<DonationPetModel> {
  final DonationPetRepository _repository;
  final _authService = Get.find<AuthService>();

  DonationPetController(this._repository);
  bool get isLogged => _authService.isLogged;

  final loading = true.obs;

  @override
  void onInit() {
    loading(true);

    int id = int.parse(Get.parameters['id']!);

    print("Msg 1");
    _repository.getDonationPet(id).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      if ((error.toString() == 'Connection failed') ||
          (error.toString() == 'Network is unreachable') ||
          (error.toString() == 'Connection timed out')) {
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(const SnackBar(
          content: Text('Sem conexão de rede'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 15),
        ));
      } else {
        print(error.toString());
        //MessageGeneralError().showAlertErrorGeneral(QuickAlertType.error);
      }
    });
    super.onInit();
  }
}
