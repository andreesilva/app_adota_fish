import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/verificationCode/controller.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodePage extends GetView<VerificationCodeController> {
  const VerificationCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VERIFICAÇÃO DE CÓDIGO',
            style: TextStyle(
                fontSize: 17, fontFamily: 'Roboto', color: ColorsApp.appTitle)),
        centerTitle: true,
        backgroundColor: ColorsApp.appBackground,
        shape: const Border(
            bottom: BorderSide(color: ColorsApp.appBorder, width: 0.5)),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16),
                        child: Text(
                          "Digite o código de 6 dígitos enviado para seu e-mail. Após gerado, o código tem validade apenas de 5 minutos.",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        showCursor: true,
                        keyboardType: TextInputType.number,
                        controller: controller.code,
                        onChanged: (value) => {
                          // debugPrint(value);
                          print(value),
                          controller.currentText.value = value,
                        },
                        animationType: AnimationType.fade,
                        autoFocus: true,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                          selectedColor: Colors.grey,
                          inactiveColor: Colors.grey,
                          activeColor: Colors.grey,
                        ),
                        beforeTextPaste: (text) {
                          return false;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          controller.hasError
                              ? "Informe o código de 6 dígitos"
                              : "",
                          style: TextStyle(
                              color: Colors.red.shade300, fontSize: 15),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.forgotPassword);
                        },
                        child: Text(
                          'Reenviar código',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Colors.blueGrey, fontSize: 12),
                          ),
                        ),
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
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                //child: const Text("Verificar"),
                                child: AnimatedBuilder(
                                  animation: controller.loadingCircular,
                                  builder: (context, _) {
                                    return controller.loadingCircular.value
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Text('Verificar');
                                  },
                                ),
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
