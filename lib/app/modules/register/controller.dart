import 'package:app_adota_fish/app/core/theme/errors.dart';
import 'package:app_adota_fish/app/data/models/city_full.dart';
import 'package:app_adota_fish/app/data/models/city_request.dart';
import 'package:app_adota_fish/app/data/models/user_address_request.dart';
import 'package:app_adota_fish/app/data/models/user_login_request.dart';
import 'package:app_adota_fish/app/data/models/user_profile_request.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/register/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:app_adota_fish/app/widgets/message_general_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../data/models/specie_request.dart';

class RegisterController extends GetxController
    with StateMixin<List<CityFullModel>> {
  final RegisterRepository _repository;

  RegisterController(this._repository);

  final formKey = GlobalKey<FormState>();

  final key_dropdown = GlobalKey<FormState>();

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

  var reference = '';
  var complement = '';

  @override
  void onInit() {
    _repository.getCitiesState(0).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      errors(error);
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

      if (referenceController.text == '') {
        reference = ' ';
      } else {
        reference = referenceController.text;
      }

      if (complementController.text == '') {
        complement = ' ';
      } else {
        complement = complementController.text;
      }

      var userAddressRequest = UserAddressRequestModel(
        clientId: value.id!,
        street: streetController.text,
        number: numberController.text,
        neighborhood: neighborhoodController.text,
        referencePoint: reference,
        cityId: cityId.value!,
        complement: complement,
      );

      _addAddress(userAddressRequest);

      Get.offAllNamed(Routes.photoClient, arguments: 1);
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

  void _addAddress(UserAddressRequestModel userAddressRequest) {
    _repository.postAddress(userAddressRequest).then((value) {},
        onError: (error) {
      Get.dialog(AlertDialog(title: Text(error.toString())));
    });
  }

  void changeState(int? stateIdSelected) {
    loading(true);
    stateId.value = stateIdSelected;

    cityId.value = null;

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

    key_dropdown.currentState?.reset();

    loading(false);
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        onConfirmBtnTap: () => Get.offAllNamed(Routes.register),
        barrierDismissible: false,
        context: Get.context!,
        text: "Houve um erro! Tente novamente.",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }
}
