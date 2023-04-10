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
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 55),
            child: Text('EDITAR DADOS',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                )),
          ),
        ),
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
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Preencha o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.emailController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Preencha o email';
                  }
                  return null;
                },
               
              onChanged: (value) {
                
                    print('First text field: ');
                  }),
              
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
                        onPressed: controller.submit,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text("Salvar"),
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
                              borderRadius: BorderRadius.circular(6),
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
