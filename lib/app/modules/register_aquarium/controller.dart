import 'package:app_adota_fish/app/core/theme/errors.dart';
import 'package:app_adota_fish/app/core/util/image_helper.dart';
import 'package:app_adota_fish/app/data/models/aquarium_request.dart';
import 'package:app_adota_fish/app/data/models/city_full.dart';
import 'package:app_adota_fish/app/data/models/photo.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/register_aquarium/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:app_adota_fish/app/core/util/firebase_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quickalert/quickalert.dart';

class RegisterAquariumController extends GetxController
    with StateMixin<List<CityFullModel>> {
  final RegisterAquariumRepository _repository;

  RegisterAquariumController(this._repository);

  final formKey = GlobalKey<FormState>();
  final loading = true.obs;
  final _authService = Get.find<AuthService>();

  var descriptionController = TextEditingController();

  int litrageValue = 0;

  var description = '';

  final litrageId = RxnInt();
  final cityId = RxnInt();

  final imageHelper = ImageHelper();

  @override
  void onInit() {
    _repository.getCitiesState(0).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      errors(error);
    });

    super.onInit();
  }

  var isProficPicPath = false.obs;
  var profilePicPath = "".obs;

  void setProfileImagePath(String path) {
    profilePicPath.value = path;
    isProficPicPath.value = true;
  }

  Future<void> submit() async {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    switch (litrageId.value!) {
      case 1:
        litrageValue = 10;
        break;
      case 2:
        litrageValue = 25;
        break;
      case 3:
        litrageValue = 50;
        break;
      case 4:
        litrageValue = 72;
        break;
      case 5:
        litrageValue = 100;
        break;
      case 6:
        litrageValue = 200;
        break;
      case 7:
        litrageValue = 0;
        break;
    }

    if (descriptionController.text == '') {
      description = ' ';
    } else {
      description = descriptionController.text;
    }

    Photo photo = await FirebaseUtil.uploadAquarium(profilePicPath.value);

    var aquariumRequest = AquariumRequestModel(
      photo: photo.filepath!,
      capacity: litrageValue,
      description: description,
    );

    _repository.register(aquariumRequest).then((value) async {
      showAlertSuccess(QuickAlertType.success);
    }, onError: (error) {
      print(error.toString());
      if ((error.toString() == 'Connection failed') ||
          (error.toString() == 'Network is unreachable') ||
          (error.toString() == 'Connection timed out')) {
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(const SnackBar(
          content: Text('Sem conexão de rede'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 15),
        ));
      } else if (error.toString() == 'Connection refused') {
        //change(null, status: RxStatus.error('Falha no servidor'));
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(const SnackBar(
          content: Text('Falha no servidor'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 15),
        ));
        print(error.toString());
      } else {
        print(error.toString());
        showAlertError(QuickAlertType.error);
      }
    });
  }

  void changeLiterage(int? literageIdSelected) {
    loading(true);

    litrageId.value = literageIdSelected;

    loading(false);
  }

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Não foi possível postar o anúncio",
        confirmBtnText: "Ok",
        type: quickAlertType,
        onConfirmBtnTap: () => Get.offAllNamed(Routes.dashboard, arguments: 2));
  }

  void showAlertSuccess(QuickAlertType quickAlertType) {
    QuickAlert.show(
      barrierDismissible: false,
      context: Get.context!,
      title: "",
      text: "Anúncio postado com sucesso!",
      confirmBtnText: "Ok",
      type: quickAlertType,
      onConfirmBtnTap: () => Get.offAllNamed(Routes.dashboard, arguments: 1),
    );
  }
}
