import 'package:app_adota_fish/app/data/models/user_login_request.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginController();

  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObscure = true.obs;

  void login() {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    var userLoginRequestModel = UserLoginRequestModel(
        email: emailController.text, password: passwordController.text);

    _authService.login(userLoginRequestModel).then((value) {
      if (Get.routing.previous == Routes.checkout) {
        Get.back(result: true);
      } else {
        Get.offAllNamed(Routes.dashboard, arguments: 0);
      }
    }, onError: (error) {
      Get.dialog(
        AlertDialog(
          title: Text("Email ou senha incorretos"),
        ),
      );
    });
  }
}
