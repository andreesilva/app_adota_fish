import 'dart:convert';

import 'package:app_adota_fish/app/data/models/forgot_password_request.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/forgotPassword/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ForgotPasswordController extends GetxController {
  final ForgotPasswordRepository _repository;

  ForgotPasswordController(this._repository);

  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();
  var email = TextEditingController();

  void submit() {
    var forgotPasswordRequestModel =
        ForgotPasswordRequestModel(email: email.text);

    _repository.forgotPassword(forgotPasswordRequestModel).then((data) {
      
       Get.offAllNamed(Routes.verificationCode, arguments: 1);
      print('Sucesso!');
    }, onError: (error) {
      print(error.toString());
      showAlertError(QuickAlertType.error);
    });
  }

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        context: Get.context!,
        title: "",
        text: "Email não cadastrado na plataforma",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }
}
