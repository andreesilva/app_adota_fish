import 'package:app_adota_fish/app/core/util/image_helper.dart';
import 'package:app_adota_fish/app/data/models/photo.dart';
import 'package:app_adota_fish/app/data/models/photo_client_request.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/photo_client/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:app_adota_fish/app/core/util/firebase_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class PhotoClientController extends GetxController {
  final PhotoClientRepository _repository;

  PhotoClientController(this._repository);

  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();

  var isProficPicPath = false.obs;
  var profilePicPath = "".obs;

  final imageHelper = ImageHelper();

  void setProfileImagePath(String path) {
    profilePicPath.value = path;
    isProficPicPath.value = true;
  }

  Future<void> submit() async {
    Get.focusScope!.unfocus();

    Photo photo = await FirebaseUtil.uploadPhotoClient(profilePicPath.value);

    var photoClientRequestModel =
        PhotoClientRequestModel(photo: photo.filepath!);

    _repository.putPhotoClient(photoClientRequestModel).then((value) {
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

  void showAlertSuccess(QuickAlertType quickAlertType) {
    QuickAlert.show(
      barrierDismissible: false,
      context: Get.context!,
      title: "Parabéns",
      text: "Cadastro realizado com sucesso!",
      confirmBtnText: "Ok",
      type: quickAlertType,
      onConfirmBtnTap: () => Get.offAllNamed(Routes.dashboard),
    );
  }

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        text: "Não foi possível finalizar o cadastro",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }
}
