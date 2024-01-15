import 'package:app_adota_fish/app/core/theme/errors.dart';
import 'package:app_adota_fish/app/data/models/donations_aquarium.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/donationAquarium/repository.dart';
import 'package:app_adota_fish/app/widgets/message_general_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

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
      errors(error);
      /*
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
      */
    });
    super.onInit();
  }
}
