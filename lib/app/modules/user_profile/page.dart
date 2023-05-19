import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/user_profile/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masked_text_field/masked_text_field.dart';

class UserProfilePage extends GetView<UserProfileController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDITAR DADOS',
            style: TextStyle(
                fontSize: 17, fontFamily: 'Roboto', color: ColorsApp.appTitle)),
        centerTitle: true,
        backgroundColor: ColorsApp.appBackground,
        shape: const Border(
            bottom: BorderSide(color: ColorsApp.appBorder, width: 0.5)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: "Nome",
                ),
                maxLength: 200,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Preencha o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                maxLength: 200,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Preencha o email';
                  }
                  return null;
                },
              ),
              MaskedTextField(
                textFieldController: controller.phoneController,
                inputDecoration: const InputDecoration(
                  labelText: 'Telefone',
                ),
                mask: '(xx)xxxxx-xxxx',
                maxLength: 14,
                onChange: (String value) {},
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          child: const Text("Cancelar")),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
