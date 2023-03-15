import 'package:app_adota_fish/app/data/models/address.dart';
import 'package:app_adota_fish/app/data/models/city_full.dart';
import 'package:app_adota_fish/app/data/models/user_address_request.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/user_address/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class UserAddressController extends GetxController
    with StateMixin<List<CityFullModel>> {
  final UserAddressRepository _repository;

  UserAddressController(this._repository);

  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();
  var streetController = TextEditingController();
  var numberController = TextEditingController();
  var neighborhoodController = TextEditingController();
  var referenceController = TextEditingController();
  var complementController = TextEditingController();
  var cityController = "";
  var stateController = "";
  final cityId = RxnInt();
  final _address = Rxn<AddressModel>();
  final stateId = RxnInt();

  final editing = RxBool(false);
  final loading = true.obs;

  var idCliente = 0;
  var idAddress = 0;

  @override
  void onInit() {
    _repository.getCitiesState(0).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });

    fetchUser();

    super.onInit();
  }

  void fetchUser() {
    loading(true);

    _repository.getUser().then((data) {
      idCliente = data.id!;

      _repository.getClient(data.id!).then((data) {
        idAddress = data.address.id;
        streetController.text = data.address.street;
        numberController.text = data.address.number;
        neighborhoodController.text = data.address.neighborhood;
        referenceController.text = data.address.referencePoint!;
        complementController.text = data.address.complement!;
        cityController = data.address.city.name;
        stateController = data.address.city.state.name;
        loading(false);
      }, onError: (error) {
        loading(false);
      });

      print(idCliente);
      print(idCliente);
      loading(false);
    }, onError: (error) {
      loading(false);
    });
  }

  void showAlertSuccess(QuickAlertType quickAlertType) {
    QuickAlert.show(
      context: Get.context!,
      title: "",
      text: "Endereço atualizado com sucesso!",
      confirmBtnText: "Ok",
      type: quickAlertType,
      onConfirmBtnTap: () => Get.back(result: true),
    );
  }

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        context: Get.context!,
        title: "",
        text: "Não foi possível atualizar o seu endereço",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }

  void submit() {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    var userAddressRequest = UserAddressRequestModel(
        id: idAddress,
        street: streetController.text,
        number: numberController.text,
        neighborhood: neighborhoodController.text,
        referencePoint: referenceController.text,
        cityId: cityId.value!,
        complement: complementController.text,
        clientId: idCliente);

    _updateAddress(userAddressRequest);
  }

  void _updateAddress(UserAddressRequestModel userAddressRequest) {
    _repository.putAddress(userAddressRequest).then((value) {
      showAlertSuccess(QuickAlertType.success);
    }, onError: (error) {
      print(error.toString());
      showAlertError(QuickAlertType.error);
    });
  }

  void changeState(int? stateIdSelected) {
    loading(true);
    stateId.value = stateIdSelected;

    _repository.getCitiesState(stateIdSelected!).then((data) {
      loading(false);
      change(data, status: RxStatus.success());
    }, onError: (error) {
      loading(false);
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  void changeCity(int? cityIdSelected) {
    loading(true);

    cityId.value = cityIdSelected;

    loading(false);
  }

  var currentPageIndex = 0.obs;
}
