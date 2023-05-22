import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/models/photo_client_request.dart';
import 'package:app_adota_fish/app/data/models/photo_donation_request.dart';
import 'package:app_adota_fish/app/data/models/specie_request.dart';
import 'package:app_adota_fish/app/data/models/pet_request.dart';
import 'package:app_adota_fish/app/data/models/photo.dart';
import 'package:app_adota_fish/app/data/models/specie.dart';
import 'package:app_adota_fish/app/modules/register_pet/repository.dart';
import 'package:app_adota_fish/app/modules/update_pet/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:app_adota_fish/app/util/firebase_util.dart';
import 'package:app_adota_fish/app/widgets/message_general_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quickalert/quickalert.dart';

//with StateMixin<Tuple2<DonationPetModel, List<SpecieModel>>> {

class MyState<T1, T2> {
  // you can use more like T3, T4...
  T1? state1;
  T2 state2;

  MyState({this.state1, required this.state2});
}

abstract class BaseController<T1, T2> extends GetxController
    with StateMixin<MyState<T1, T2>> {}

class UpdatePetController
    extends BaseController<DonationPetModel, List<SpecieModel>> {
  final UpdatePetRepository _repository;

  UpdatePetController(this._repository);

  final key_dropdown = GlobalKey<FormState>();

  final formKey = GlobalKey<FormState>();
  final loading = true.obs;

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

  var cityController = "".obs;
  var specieController = "";
  var specieIdController = 0.obs;
  var amountIdController = 0.obs;
  var petIdController = 0;
  var watherIdController = 0.obs;

  var photoPet =
      "https://firebasestorage.googleapis.com/v0/b/app-adota-fish.appspot.com/o/images%2Faccount%2FVector_1.png?alt=media&token=a8237bea-4fe5-4a17-9080-8117b78b7458";

  @override
  void onInit() {
    fetchDonation();
    _repository.getSpecies(0).then((data) {
      //change(data, status: RxStatus.success());
      change(MyState(state1: null, state2: data), status: RxStatus.success());
    }, onError: (error) {
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
        // MessageGeneralError().showAlertErrorGeneral(QuickAlertType.error);
      }
    });

    super.onInit();
  }

  void fetchDonation() {
    loading(true);

    int id = int.parse(Get.parameters['id']!);

    print("Msg 1");
    _repository.getDonationPet(id).then((data) {
      petIdController = data.petId;
      photoPet = data.pet.photo!;
      specieIdController.value = data.pet.specie!.id!;
      specieController = data.pet.specie!.name;
      amountIdController.value = data.pet.amount!;
      observationController.text = data.pet.observation!;
      watherIdController.value = data.pet.specie!.typeWater!;

      change(MyState(state1: data, state2: []), status: RxStatus.success());
    }, onError: (error) {
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
  }

  var isProficPicPath = false.obs;
  var profilePicPath = "".obs;

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

    var petRequest = PetRequestModel(
        id: petIdController,
        photo: photoPet,
        specie: specieId,
        amount: amountId.value!,
        observation: observation);

    _repository.putPet(petRequest).then((value) async {
      showAlertSuccess(QuickAlertType.success);
    }, onError: (error) {
      print(error.toString());
      showAlertError(QuickAlertType.error);
    });
  }

  Future<void> setProfileImagePath(String path, int idPet) async {
    profilePicPath.value = path;
    isProficPicPath.value = true;

    Photo photo = await FirebaseUtil.uploadPet(path);

    // Photo photo = await FirebaseUtil.uploadPhotoClient(path);

    var photoDonationRequestModel =
        PhotoDonationRequestModel(photo: photo.filepath!, id: idPet);

    _repository.putPhotoPet(photoDonationRequestModel).then((value) {
      showPhotoAlertSuccess(QuickAlertType.success);
    }, onError: (error) {
      //print(error.toString());
      showPhotoAlertError(QuickAlertType.error);
    });
  }

  void changeTypeWater(int? typeWaterIdSelected) {
    loading(true);
    typeWaterId.value = typeWaterIdSelected;

    _repository.getSpecies(typeWaterIdSelected!).then((data) {
      loading(false);
      //change(data, status: RxStatus.success());
      change(MyState(state1: null, state2: data), status: RxStatus.success());
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
