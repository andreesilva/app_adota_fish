import 'package:app_adota_fish/app/core/theme/errors.dart';
import 'package:app_adota_fish/app/data/models/donations_aquarium.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/home/repository.dart';
import 'package:app_adota_fish/app/widgets/message_general_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';

class HomeController extends GetxController
    with StateMixin<List<DonationAquariumModel>> {
  HomeRepository _repository;

  HomeController(this._repository);

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

    _repository.getDonations(id).then((data) {
      if (data.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(data.cast<DonationAquariumModel>(), status: RxStatus.success());
      }
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
