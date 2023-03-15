import 'package:app_adota_fish/app/modules/forgotPassword/controller.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 55),
            child: Text('RECUPERAÇÃO DE CONTA',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                )),
          ),
        ),
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            SingleChildScrollView(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Esqueçeu a sua senha?',
                        style: TextStyle(
                            //color: Color.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16),
                        child: Text(
                          "Não se preocupe! Insira o seu email de cadastro e enviaremos instruções para você'.",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      TextFormField(
                        controller: controller.email,
                        decoration: const InputDecoration(
                          labelText: "Email",
                        ),
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'Informe o seu email';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: controller.submit,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Text("Receber instruções"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
          ])),
    );
  }
}
