import 'package:app_adota_fish/app/data/models/password.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/resetPassword/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class ResetPasswordController extends GetxController {
  final ResetPasswordRepository _repository;

  ResetPasswordController(this._repository);

  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();

  final loading = true.obs;
  bool get isLogged => _authService.isLogged;

  dynamic passwordController;
  dynamic actualPassword;
  var newPassword = TextEditingController();
  var confirmPassword = TextEditingController();
  var emailController = TextEditingController();
  var isObscure = true.obs;
  var isObscure2 = true.obs;

  final loadingCircular = ValueNotifier<bool>(false);

  @override
  void onInit() {
    emailController.text = Get.parameters['email']!;

    super.onInit();
  }

  void logout() async {
    await _authService.logout();

    Get.offAllNamed(Routes.dashboard);
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

  void showAlertSuccess(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Senha redefinida com sucesso!",
        confirmBtnText: "Ok",
        type: quickAlertType,
        onConfirmBtnTap: logout);
  }

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Não foi possível redefinir a senha",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }

  void submit() {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    var newPassword_ =
        PasswordModel(password: newPassword.text, email: emailController.text);

    _repository.putPassword(newPassword_).then((value) {
      showAlertSuccess(QuickAlertType.success);

      loadingCircular.value = false;
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

      loadingCircular.value = false;
    });
  }
}
