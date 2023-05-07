import 'package:app_adota_fish/app/data/models/city_full.dart';
import 'package:app_adota_fish/app/data/models/city_request.dart';
import 'package:app_adota_fish/app/data/models/user_address_request.dart';
import 'package:app_adota_fish/app/data/models/user_login_request.dart';
import 'package:app_adota_fish/app/data/models/user_profile_request.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/register/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/specie_request.dart';

class RegisterController extends GetxController
    with StateMixin<List<CityFullModel>> {
  final RegisterRepository _repository;

  RegisterController(this._repository);

  final formKey = GlobalKey<FormState>();
  final loading = true.obs;
  final _authService = Get.find<AuthService>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var streetController = TextEditingController();
  var numberController = TextEditingController();
  var neighborhoodController = TextEditingController();
  var referenceController = TextEditingController();
  var complementController = TextEditingController();
  final stateId = RxnInt();
  final cityId = RxnInt();

  dynamic actualPassword;
  var newPassword = TextEditingController();
  var confirmPassword = TextEditingController();
  var isObscure = true.obs;
  var isObscure2 = true.obs;

  @override
  void onInit() {
    _repository.getCitiesState(0).then((data) {
      print("Cidade 1");
      change(data, status: RxStatus.success());
    }, onError: (error) {
      print("Cidade 2");
      change(null, status: RxStatus.error(error.toString()));
    });

    super.onInit();
  }

  void onChangedActualPassword(value) {
    actualPassword = value;
  }

  void onChangedNewPassword(value) {
    newPassword = value;
  }

  void onChangedConfirmPassword(value) {
    confirmPassword = value;
  }

  void submit() {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    var userProfileRequest = UserProfileRequestModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: newPassword.text,
    );

    _repository.register(userProfileRequest).then((value) async {
      await _authService.login(UserLoginRequestModel(
        email: emailController.text,
        password: newPassword.text,
      ));

      var userAddressRequest = UserAddressRequestModel(
        clientId: value.id!,
        street: streetController.text,
        number: numberController.text,
        neighborhood: neighborhoodController.text,
        referencePoint: referenceController.text,
        cityId: cityId.value!,
        complement: complementController.text,
      );

      _addAddress(userAddressRequest);

      Get.offAllNamed(Routes.photoClient, arguments: 1);
    }, onError: (error) {
      Get.dialog(AlertDialog(title: Text(error.toString())));
    });
  }

  void _addAddress(UserAddressRequestModel userAddressRequest) {
    _repository.postAddress(userAddressRequest).then((value) {},
        onError: (error) {
      Get.dialog(AlertDialog(title: Text(error.toString())));
    });
  }

  void changeState(int? stateIdSelected) {
    loading(true);
    stateId.value = stateIdSelected;

    _repository.getCitiesState(stateIdSelected!).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
    loading(false);
  }

  void changeCity(int? cityIdSelected) {
    loading(true);

    cityId.value = cityIdSelected;

    loading(false);
  }
}
