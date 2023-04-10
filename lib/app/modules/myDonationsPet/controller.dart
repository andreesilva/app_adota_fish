import 'package:app_adota_fish/app/data/models/donations_aquarium.dart';
import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/myDonationsPet/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class MyDonationsPetController extends GetxController
    with StateMixin<List<DonationPetModel>> {
  MyDonationsPetRepository _repository;

  MyDonationsPetController(this._repository);

  final _authService = Get.find<AuthService>();

  bool get isLogged => _authService.isLogged;

  @override
  void onInit() {
    _repository.getMyDonationsPet().then((data) {
      
      if (data.isEmpty) {
        print("Msg 1");
        change([], status: RxStatus.empty());
      } else {
        print("Msg 2");
        change(data, status: RxStatus.success());
      }
    }, onError: (error) {
      print("Msg 3");
      print(error.toString());
      change(null, status: RxStatus.error(error.toString()));
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
        onConfirmBtnTap: () => Get.offAllNamed(Routes.myDonationsPet));
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
        onConfirmBtnTap: () => Get.offAllNamed(Routes.myDonationsPet));
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

  Future<void> inactivatePet(id) async {
    _repository.putPetInactivate(id).then((value) {
      showAlertSuccess(QuickAlertType.success);
    }, onError: (error) {
      print(error.toString());
      showAlertError(QuickAlertType.error);
    });
  }

  Future<void> activatePet(id) async {
    _repository.putActivatePet(id).then((value) {
      showAlertActivateSuccess(QuickAlertType.success);
    }, onError: (error) {
      print(error.toString());
      showAlertActivateError(QuickAlertType.error);
    });
  }

  Future<void> deletePet(id) async {
    _repository.deletePet(id).then((value) {
      showAlertDeleteSuccess(QuickAlertType.success);
    }, onError: (error) {
      print(error.toString());
      showAlertDeleteError(QuickAlertType.error);
    });
  }
}
