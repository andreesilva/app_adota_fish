import 'package:app_adota_fish/app/core/theme/errors.dart';
import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/allDonationPet/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:app_adota_fish/app/widgets/message_general_error.dart';

class AllDonationPetController extends GetxController
    with StateMixin<List<DonationPetModel>> {
  AllDonationPetRepository _repository;

  AllDonationPetController(this._repository);

  final _authService = Get.find<AuthService>();

  bool get isLogged => _authService.isLogged;

  final loading = true.obs;

  @override
  void onInit() {
    loading(true);

    int id = 0;

    if (Get.parameters.isNotEmpty) {
      id = int.parse(Get.parameters["id"]!);
    }

    _repository.getDonationsPets(id).then((data) {
      if (data.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(data.cast<DonationPetModel>(), status: RxStatus.success());
      }
    }, onError: (error) {
      print(error);

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
      } else if (error.toString() == 'Connection refused') {
        change(null, status: RxStatus.error('Falha no servidor'));
      } else {
        print(error.toString());

        change(null, status: RxStatus.error(error.toString()));
      }
      */
    });

    super.onInit();
  }
}
