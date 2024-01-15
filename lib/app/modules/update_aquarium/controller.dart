import 'package:app_adota_fish/app/core/theme/errors.dart';
import 'package:app_adota_fish/app/core/util/image_helper.dart';
import 'package:app_adota_fish/app/data/models/aquarium_not_photo_request.dart';
import 'package:app_adota_fish/app/data/models/donations_aquarium.dart';
import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/models/pet_not_photo_request.dart';
import 'package:app_adota_fish/app/data/models/photo_client_request.dart';
import 'package:app_adota_fish/app/data/models/photo_donation_request.dart';
import 'package:app_adota_fish/app/data/models/specie_request.dart';
import 'package:app_adota_fish/app/data/models/pet_request.dart';
import 'package:app_adota_fish/app/data/models/photo.dart';
import 'package:app_adota_fish/app/data/models/specie.dart';
import 'package:app_adota_fish/app/modules/register_pet/repository.dart';
import 'package:app_adota_fish/app/modules/update_aquarium/repository.dart';
import 'package:app_adota_fish/app/modules/update_pet/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:app_adota_fish/app/core/util/firebase_util.dart';
import 'package:app_adota_fish/app/widgets/message_general_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quickalert/quickalert.dart';

class MyState<T1, T2> {
  T1? state1;
  T2 state2;

  MyState({this.state1, required this.state2});
}

abstract class BaseController<T1, T2> extends GetxController
    with StateMixin<MyState<T1, T2>> {}

class UpdateAquariumController
    extends BaseController<DonationAquariumModel, List<SpecieModel>> {
  final UpdateAquariumRepository _repository;

  UpdateAquariumController(this._repository);

  final key_dropdown = GlobalKey<FormState>();

  final formKey = GlobalKey<FormState>();
  final loading = true.obs;

  int litrageValue = 0;

  final litrageId = RxnInt();

  var capacityIdController = 0.obs;

  var aquariumIdController = 0;

  var photoAquarium =
      "https://firebasestorage.googleapis.com/v0/b/app-adota-fish.appspot.com/o/images%2Fbackground_white.jpeg?alt=media&token=0ac0f512-b273-49af-9247-0add396c3cb7";

  var descriptionController = TextEditingController();

  var description = '';

  var capacity = "".obs;

  final imageHelper = ImageHelper();

  @override
  void onInit() {
    fetchDonation();

    super.onInit();
  }

  void fetchDonation() {
    loading(true);

    int id = int.parse(Get.parameters['id']!);
    _repository.getDonationAquarium(id).then((data) {
      aquariumIdController = data.id;
      photoAquarium = data.aquarium.photo!;
      capacityIdController.value = data.aquarium.capacity!;

      descriptionController.text = data.aquarium.description!;

      switch (data.aquarium.capacity!) {
        case 10:
          capacity.value = '10';
          break;
        case 25:
          capacity.value = '25';
          break;
        case 50:
          capacity.value = '50';
          break;
        case 72:
          capacity.value = '72';
          break;
        case 100:
          capacity.value = '100';
          break;
        case 200:
          capacity.value = '200';
          break;
        case 0:
          capacity.value = 'Acima de 200';
          break;
      }

      capacity.value;

      change(MyState(state1: data, state2: []), status: RxStatus.success());
    }, onError: (error) {
      errors(error);
    });
  }

  var isProficPicPath = false.obs;
  var profilePicPath = "".obs;

  Future<void> submit() async {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    switch (litrageId.value) {
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

    var aquariumNotPhotoRequestModel = AquariumNotPhotoRequestModel(
        id: aquariumIdController,
        capacity: litrageValue,
        description: description);

    _repository.putAquarium(aquariumNotPhotoRequestModel).then((value) async {
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

  Future<void> setProfileImagePath(String path, int idPet) async {
    profilePicPath.value = path;
    isProficPicPath.value = true;

    Photo photo = await FirebaseUtil.uploadAquarium(path);

    var photoDonationRequestModel =
        PhotoDonationRequestModel(photo: photo.filepath!, id: idPet);

    _repository.putPhotoAquarium(photoDonationRequestModel).then((value) {
      showPhotoAlertSuccess(QuickAlertType.success);
    }, onError: (error) {
      //print(error.toString());
      showPhotoAlertError(QuickAlertType.error);
    });
  }

  void changeLiterage(int? literageIdSelected) {
    loading(true);

    litrageId.value = literageIdSelected;

    loading(false);
  }

  void showAlertSuccess(QuickAlertType quickAlertType) {
    QuickAlert.show(
        context: Get.context!,
        title: "",
        text: "Anúncio atualizado com sucesso!",
        confirmBtnText: "Ok",
        type: quickAlertType,
        onConfirmBtnTap: () =>
            Get.offAllNamed(Routes.myDonationsAquarium, arguments: 0));
  }

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Não foi possível postar o anúncio",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }

  void showPhotoAlertSuccess(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Foto atualizada com sucesso!",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }

  void showPhotoAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Não foi possível atualizar a suas foto",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }
}
