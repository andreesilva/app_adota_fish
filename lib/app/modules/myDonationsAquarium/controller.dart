import 'package:app_adota_fish/app/data/models/donations_aquarium.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/myDonationsAquarium/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:app_adota_fish/app/widgets/message_general_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class MyDonationsAquariumController extends GetxController
    with StateMixin<List<DonationAquariumModel>> {
  MyDonationsAquariumRepository _repository;

  MyDonationsAquariumController(this._repository);

  final _authService = Get.find<AuthService>();

  bool get isLogged => _authService.isLogged;

  @override
  void onInit() {
    _repository.getMyDonationsAquarium().then((data) {
      if (data.isEmpty) {
        print("Msg 1");
        change([], status: RxStatus.empty());
      } else {
        print("Msg 2");
        change(data, status: RxStatus.success());
      }
    }, onError: (error) {
      print("Msg 3");

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

  void showAlertSuccess(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Anúncio inativado com sucesso!",
        confirmBtnText: "Ok",
        type: quickAlertType,
        onConfirmBtnTap: () => Get.offAllNamed(Routes.myDonationsAquarium));
  }

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Não foi possível inativar o anúncio",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }

  void showAlertActivateSuccess(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Anúncio ativado com sucesso!",
        confirmBtnText: "Ok",
        type: quickAlertType,
        onConfirmBtnTap: () => Get.offAllNamed(Routes.myDonationsAquarium));
  }

  void showAlertActivateError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Não foi possível ativar o anúncio",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }

  void showAlertDeleteSuccess(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Anúncio excluído com sucesso!",
        confirmBtnText: "Ok",
        type: quickAlertType,
        onConfirmBtnTap: () => Get.offAllNamed(Routes.dashboard));
  }

  void showAlertDeleteError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Não foi possível excluír o anúncio",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }

  Future<void> inactivateAquarium(id) async {
    _repository.putAquariumInactivate(id).then((value) {
      showAlertSuccess(QuickAlertType.success);
    }, onError: (error) {
      print(error.toString());
      showAlertError(QuickAlertType.error);
    });
  }

  Future<void> activateAquarium(id) async {
    _repository.putActivateAquarium(id).then((value) {
      showAlertActivateSuccess(QuickAlertType.success);
    }, onError: (error) {
      print(error.toString());
      showAlertActivateError(QuickAlertType.error);
    });
  }

  Future<void> deleteAquarium(id) async {
    _repository.deleteAquarium(id).then((value) {
      showAlertDeleteSuccess(QuickAlertType.success);
    }, onError: (error) {
      print(error.toString());
      showAlertDeleteError(QuickAlertType.error);
    });
  }
}
