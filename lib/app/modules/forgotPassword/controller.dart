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
//import 'package:flutter_html/flutter_html.dart';

class ForgotPasswordController extends GetxController {
  final ForgotPasswordRepository _repository;

  ForgotPasswordController(this._repository);

  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();
  var email = TextEditingController();
  var name = '';
  var subject = 'Recuperação de conta';
  var message = '';

  void submit() {
    var forgotPasswordRequestModel =
        ForgotPasswordRequestModel(email: email.text);

    _repository.forgotPassword(forgotPasswordRequestModel).then((data) {
      //message ='Olá ${data.name},\n\n Você solicitou a validação do e-mail pessoal para recuperar uma conta de acesso no Adota Fish.\n\n Um código (PIN de segurança) foi criado para essa validação. Esse código tem validade de 5 minutos para ser utilizado.\n\n Código de validação\n\n ${data.code.toString()}\n\n Adota Fish';

      const serviceId = 'service_eoxpfar';
      const templateId = 'template_r5qsebc';
      const userId = 'c1d7IRsqqp6G03nwQ';
      const accessToken = 'QnRybGIpOlWvULeU_2doL';

      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

      try {
        /*
        final response = http.post(url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'service_id': serviceId,
              'template_id': templateId,
              'user_id': userId,
              'accessToken': accessToken,
              'template_params': {
                'user_email': email.text,
                'user_subject': subject,
                'user_name': data.name,
                'code_verification': data.code.toString(),
              }
            }));
            */

        Get.offAllNamed(Routes.verificationCode, arguments: 1);
      } catch (error) {
        print(error.toString());
      }
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
