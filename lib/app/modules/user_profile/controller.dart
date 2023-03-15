import 'package:app_adota_fish/app/data/models/user_profile_request.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/user_profile/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class UserProfileController extends GetxController {
  final UserProfileRepository _repository;

  UserProfileController(this._repository);

  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  final loading = true.obs;
  bool get isLogged => _authService.isLogged;

  @override
  void onInit() {
    ever(_authService.user, (_) => fetchUser());

    fetchUser();

    super.onInit();
  }

  void fetchUser() {
    loading(true);

    _repository.getUser().then((data) {
      nameController.text = data.name;
      emailController.text = data.email;
      phoneController.text = data.phone;

      loading(false);
    }, onError: (error) {
      loading(false);
    });
  }

  void logout() async {
    await _authService.logout();

    Get.offAllNamed(Routes.dashboard);
  }

  void showAlertSuccess(QuickAlertType quickAlertType) {
    QuickAlert.show(
      context: Get.context!,
      title: "",
      text: "Dados atualizados com sucesso!",
      confirmBtnText: "Ok",
      type: quickAlertType,
    );
  }

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        context: Get.context!,
        title: "",
        text: "Não foi possível atualizar os seus dados",
        confirmBtnText: "Ok",
        type: quickAlertType);
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
        password: passwordController.text);

    _repository.putUser(userProfileRequest).then((value) {
      showAlertSuccess(QuickAlertType.success);

      passwordController.text = '';
    }, onError: (error) {
      print(error.toString());
      showAlertError(QuickAlertType.error);
    });
  }
}
