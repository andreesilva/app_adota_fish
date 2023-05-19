import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/password/controller.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class FrenchStrings extends FlutterPwValidatorStrings {
  @override
  final String atLeast = 'Deve conter mais de 5 caracteres';
  @override
  final String uppercaseLetters = 'Ao menos uma letra maiúscula';
  @override
  final String numericCharacters = 'Ao menos um número';
  @override
  final String specialCharacters = 'Ao menos um caractér especial';
}

class PasswordPage extends GetView<PasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOVA SENHA',
            style: TextStyle(
                fontSize: 17, fontFamily: 'Roboto', color: ColorsApp.appTitle)),
        centerTitle: true,
        backgroundColor: ColorsApp.appBackground,
        shape: const Border(
            bottom: BorderSide(color: ColorsApp.appBorder, width: 0.5)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Obx(
          () => Column(
            children: [
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.newPassword,
                      decoration: InputDecoration(
                        suffixIcon: Obx(() => GestureDetector(
                              onTap: () {
                                controller.isObscure.value =
                                    !controller.isObscure.value;
                              },
                              child: Icon(controller.isObscure.value
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            )),
                        labelText: "Nova Senha",
                      ),
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Campo Obrigatório';
                        } else {
                          return null;
                        }
                      },
                      onChanged: controller.onChangedNewPassword,
                      obscureText: controller.isObscure.value,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    FlutterPwValidator(
                      controller: controller.newPassword,
                      minLength: 5,
                      uppercaseCharCount: 1,
                      numericCharCount: 1,
                      specialCharCount: 1,
                      width: 428,
                      height: 140,
                      strings: FrenchStrings(),
                      onSuccess: () {},
                    ),
                    TextFormField(
                      controller: controller.confirmPassword,
                      decoration: InputDecoration(
                        suffixIcon: Obx(() => GestureDetector(
                              onTap: () {
                                controller.isObscure2.value =
                                    !controller.isObscure2.value;
                              },
                              child: Icon(controller.isObscure2.value
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            )),
                        labelText: "Confirmar Senha",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo Obrigatório';
                          // ignore: unrelated_type_equality_checks
                        } else if (controller.newPassword.text !=
                            controller.confirmPassword.text) {
                          return "As senhas não são iguais";
                        } else {
                          return null;
                        }
                      },
                      onChanged: controller.onChangedConfirmPassword,
                      obscureText: controller.isObscure2.value,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            /*
                            child: ElevatedButton(
                                onPressed: () => {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }),
                                      controller.submit(),
                                    },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Text("Salvar")),
*/
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              child: AnimatedBuilder(
                                animation: controller.loadingCircular,
                                builder: (context, _) {
                                  return controller.loadingCircular.value
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Text('Salvar');
                                },
                              ),
                              onPressed: () => {
                                if (controller.formKey.currentState!.validate())
                                  {
                                    controller.loadingCircular.value = true,
                                    controller.submit(),
                                  },
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: const Text("Cancelar")),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
