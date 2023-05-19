import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/login/controller.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ACESSAR',
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
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Center(
                            child: Image.asset(
                          'assets/login_adota_fish.jpg',
                          width: 500,
                          height: 250,
                        )),
                      ),
                      TextFormField(
                        controller: controller.emailController,
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
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
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
                            labelText: "Senha",
                          ),
                          obscureText: controller.isObscure.value,
                          validator: (String? value) {
                            if (value != null && value.isEmpty) {
                              return 'Informe a sua senha';
                            }
                            return null;
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
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
                                        : const Text('Entrar');
                                  },
                                ),
                                onPressed: () => {
                                  if (controller.formKey.currentState!
                                      .validate())
                                    {
                                      controller.loadingCircular.value = true,
                                      controller.login(),
                                    },
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 187, bottom: 0),
                              child: TextButton(
                                  onPressed: () =>
                                      Get.toNamed(Routes.forgotPassword),
                                  child: const Text(
                                    "Esqueçeu a sua senha?",
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 10.5),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Get.toNamed(Routes.register),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              child: const Text('Quero criar a minha conta'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ])),
    );
  }
}
