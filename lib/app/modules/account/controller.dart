import 'package:app_adota_fish/app/data/models/address.dart';
import 'package:app_adota_fish/app/data/models/photo.dart';
import 'package:app_adota_fish/app/data/models/photo_client_request.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/account/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:app_adota_fish/app/util/firebase_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class AccountController extends GetxController
    with StateMixin<List<AddressModel>> {
  final AccountRepository _repository;

  AccountController(this._repository);

  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();
  final address = AddressModel;
  final loading = true.obs;
  var photoController = TextEditingController();

  var isProficPicPath = false.obs;
  var profilePicPath = "".obs;

  var photoClient =
      "https://firebasestorage.googleapis.com/v0/b/app-adota-fish.appspot.com/o/images%2Fimg-2023-02-13%2015%3A00%3A16.710888.jpg?alt=media&token=04591d46-aae3-437a-a40b-9c18c9fcf904";

  @override
  void onInit() {
    ever(_authService.user, (_) => fetchUser());

    fetchUser();

    print(photoClient);

    super.onInit();
  }

  void fetchUser() {
    loading(true);

    _repository.getUser().then((data) {
      photoClient = data.photo!;
      data.email;
      data.phone;

      loading(false);
    }, onError: (error) {
      loading(false);
    });

    //print(user.photo);
  }

  Future<void> setProfileImagePath(String path) async {
    profilePicPath.value = path;
    isProficPicPath.value = true;

    Photo photo = await FirebaseUtil.uploadPhotoClient(path);

    var photoClientRequestModel =
        PhotoClientRequestModel(photo: photo.filepath!);

    _repository.putPhotoClient(photoClientRequestModel).then((value) {
      showAlertSuccess(QuickAlertType.success);
    }, onError: (error) {
      print(error.toString());
      showAlertError(QuickAlertType.error);
    });
  }

  void logout() async {
    await _authService.logout();

    Get.offAllNamed(Routes.dashboard);
  }

  void showAlertSuccess(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Foto atualizada com sucesso!",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Não foi possível atualizar a suas foto",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }
}
