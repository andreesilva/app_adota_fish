import 'package:app_adota_fish/app/data/models/user_login_request.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginController extends GetxController {
  LoginController();

  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObscure = true.obs;

  final loadingCircular = ValueNotifier<bool>(false);

  void login() {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    var userLoginRequestModel = UserLoginRequestModel(
        email: emailController.text, password: passwordController.text);

    _authService.login(userLoginRequestModel).then((value) {
      Get.offAllNamed(Routes.dashboard, arguments: 0);
    }, onError: (error) {
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

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Email ou senha incorretos",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }
}
