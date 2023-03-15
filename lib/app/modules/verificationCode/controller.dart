import 'dart:convert';

import 'package:app_adota_fish/app/data/models/forgot_password_request.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/verificationCode/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
//import 'package:flutter_html/flutter_html.dart';

class VerificationCodeController extends GetxController {
  final VerificationCodeRepository _repository;

  VerificationCodeController(this._repository);

  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();
  var code = TextEditingController();

  void submit() {
    _repository.getVerificationCode(int.parse(code.text)).then((data) {
      print('Sucesso!');
      //Get.offAllNamed(Routes.resetPassword, arguments: data.email);
      Get.toNamed(Routes.resetPassword.replaceFirst(':email', data.email!));
      print(data.email);
    }, onError: (error) {
      print(error.toString());
      showAlertError(QuickAlertType.error);
    });
  }

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        context: Get.context!,
        title: "",
        text: "Código inválido ou já expirado. Informe o código correto.",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }
}
