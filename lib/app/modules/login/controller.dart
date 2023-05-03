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

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Email ou senha incorretos",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }

  void login() {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    var userLoginRequestModel = UserLoginRequestModel(
        email: emailController.text, password: passwordController.text);

    _authService.login(userLoginRequestModel).then((value) {
     // if (Get.routing.previous == Routes.checkout) {
        Get.back(result: true);
     // } else {
        Get.offAllNamed(Routes.dashboard, arguments: 0);
      //}
    }, onError: (error) {
     showAlertError(QuickAlertType.error);
    });
  }
}
