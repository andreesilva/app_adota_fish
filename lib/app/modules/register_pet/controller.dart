import 'package:app_adota_fish/app/data/models/specie_request.dart';
import 'package:app_adota_fish/app/data/models/pet_request.dart';
import 'package:app_adota_fish/app/data/models/photo.dart';
import 'package:app_adota_fish/app/data/models/specie.dart';
//import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/register_pet/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:app_adota_fish/app/util/firebase_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quickalert/quickalert.dart';

class RegisterPetController extends GetxController
    with StateMixin<List<SpecieModel>> {
  final RegistePetRepository _repository;

  RegisterPetController(this._repository);

  final formKey = GlobalKey<FormState>();
  final loading = true.obs;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var amountController = TextEditingController();

  var descriptionController = TextEditingController();

  int litrageValue = 0;
  int specieId = 0;

  var observation = '';

  var streetController = TextEditingController();
  var numberController = TextEditingController();
  var neighborhoodController = TextEditingController();
  var referenceController = TextEditingController();
  var complementController = TextEditingController();
  final specieName = RxnString();
  final typeWaterId = RxnInt();
  final amountId = RxnInt();
  var observationController = TextEditingController();

  @override
  void onInit() {
    _repository.getSpecies(0).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });

    super.onInit();
  }

  var isProficPicPath = false.obs;
  var profilePicPath = "".obs;

  void setProfileImagePath(String path) {
    profilePicPath.value = path;
    isProficPicPath.value = true;
  }

  void showAlertSuccess(QuickAlertType quickAlertType) {
    QuickAlert.show(
      barrierDismissible: false,
      context: Get.context!,
      title: "",
      text: "Anúncio postado com sucesso!",
      confirmBtnText: "Ok",
      type: quickAlertType,
      onConfirmBtnTap: () => Get.offAllNamed(Routes.dashboard, arguments: 0),
    );
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

  Future<void> submit() async {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }


    if (observationController.text == '') {
      observation = ' ';
    } else {
      observation = observationController.text;
    }

    Photo photo = await FirebaseUtil.uploadPet(profilePicPath.value);

    var petRequest = PetRequestModel(
        photo: photo.filepath!,
        specie: specieId,
        amount: amountId.value!,
        observation: observation);

    _repository.register(petRequest).then((value) async {
      showAlertSuccess(QuickAlertType.success);
    }, onError: (error) {
      print(error.toString());
      showAlertError(QuickAlertType.error);
    });
  }

  void changeTypeWater(int? typeWaterIdSelected) {
    loading(true);
    typeWaterId.value = typeWaterIdSelected;

    _repository.getSpecies(typeWaterIdSelected!).then((data) {
      loading(false);
      change(data, status: RxStatus.success());
    }, onError: (error) {
      loading(false);
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  void changeSpecie(String specieNameSelected) {
    loading(true);

    specieName.value = specieNameSelected;

    var specieRequest = SpecieRequestModel(name: specieName.value!);

    _repository.getSpecie(specieRequest).then((data) {
      specieId = data.id!;

      print('${data.id} --- codigo');
    }, onError: (error) {
      print(error.toString());
    });
    loading(false);
  }

  void changeAmount(int? amountIdSelected) {
    loading(true);

    amountId.value = amountIdSelected;

    loading(false);
  }
}
