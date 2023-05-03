import 'package:app_adota_fish/app/modules/register/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masked_text_field/masked_text_field.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';

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

class RegisterPage extends GetView<RegisterController> {
  final _valores = [
    'Selecione o estado',
     'Acre',
'Alagoas',
'Amazonas',
'Amapá',
'Bahia',
'Ceará',
'Distrito Federal',
'Espírito Santo',
'Goiás',
'Maranhão',
'Minas Gerais',
'Mato Grosso do Sul',
'Mato Grosso',
'Pará',
'Paraíba',
'Pernambuco',
'Piauí',
'Paraná',
'Rio de Janeiro',
'Rio Grande do Norte',
'Rondônia',
'Roraima',
'Rio Grande do Sul',
'Santa Catarina',
'Sergipe',
'São Paulo',
'Tocantins',
  ];

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(right: 55),
              child: Text('CRIAR CONTA',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Roboto',
                  )),
            ),
          ),
        ),
        body: controller.obx(
          (state) => SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Form(
              key: controller.formKey,
              child: Obx(
                () => Column(
                  children: [
                    TextFormField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Preencha o seu nome';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Preencha o seu email';
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
                    TextFormField(
                      controller: controller.streetController,
                      decoration: const InputDecoration(
                        labelText: "Rua",
                      ),
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Preencha o nome da rua';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controller.numberController,
                      decoration: const InputDecoration(
                        labelText: "Número",
                      ),
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Preencha o número  da rua/apt';
                        }
                        return null;
                      },
                    ),
                    
                    TextFormField(
                      controller: controller.neighborhoodController,
                      decoration: const InputDecoration(
                        labelText: "Bairro",
                      ),
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Preencha o nome do bairro';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controller.referenceController,
                      decoration: const InputDecoration(
                        labelText: "Ponto de referência",
                      ),
                    ),
                    TextFormField(
                      controller: controller.complementController,
                      decoration: const InputDecoration(
                        labelText: "Complemento",
                      ),
                    ),
                    DropdownButtonFormField(
                      value: controller.stateId.value,
                      items: _valores
                          .asMap()
                          .entries
                          .map((state) => DropdownMenuItem<int>(
                              value: state.key, child: Text(state.value)))
                          .toList(),
                      onChanged: controller.changeState,
                      decoration: const InputDecoration(
                        labelText: 'Estado',
                      ),
                      validator: (int? value) {
                        if (value == null) {
                          return 'Selecione um estado';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      value: controller.cityId.value,
                      items: state!
                          .map((state) => DropdownMenuItem<int>(
                              value: state.id, child: Text(state.name)))
                          .toList(),
                      onChanged: controller.changeCity,
                      decoration: const InputDecoration(
                        labelText: 'Cidade',
                      ),
                      validator: (int? value) {
                        if (value == null) {
                          return 'Selecione uma cidade';
                        }
                        return null;
                      },
                    ),
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
                          return controller.confirmPassword.text;
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
                            child: ElevatedButton(
                              onPressed: controller.submit,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text('Continuar'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
