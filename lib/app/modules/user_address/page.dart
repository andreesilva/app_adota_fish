import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/user_address/controller.dart';
import 'package:app_adota_fish/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddressPage extends GetView<UserAddressController> {
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
  var nameTypeWater = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDITAR ENDEREÇO',
            style: TextStyle(
                fontSize: 17, fontFamily: 'Roboto', color: ColorsApp.appTitle)),
        centerTitle: true,
        backgroundColor: ColorsApp.appBackground,
        shape: const Border(
            bottom: BorderSide(color: ColorsApp.appBorder, width: 0.5)),
      ),
      body: controller.obx(
        (state) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.streetController,
                  decoration: const InputDecoration(
                    labelText: "Rua",
                    labelStyle: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto'),
                  ),
                  maxLength: 254,
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
                    labelStyle: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto'),
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
                    labelStyle: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto'),
                  ),
                  maxLength: 254,
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
                    labelStyle: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto'),
                  ),
                  maxLength: 254,
                ),
                TextFormField(
                  controller: controller.complementController,
                  decoration: const InputDecoration(
                    labelText: "Complemento",
                    labelStyle: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto'),
                  ),
                  maxLength: 254,
                ),
                Obx(
                  () => DropdownButtonFormField(
                    value: controller.stateIdController.value,
                    items: _valores
                        .asMap()
                        .entries
                        .map((state) => DropdownMenuItem<int>(
                            value: state.key,
                            child: Text(
                              state.value,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
                            )))
                        .toList(),
                    onChanged: controller.changeState,
                    decoration: const InputDecoration(
                      labelText: 'Estado',
                      labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto'),
                    ),
                    hint: Text(controller.stateController),
                    validator: (int? value) {
                      if (value == null) {
                        return 'Selecione um estado';
                      }
                      return null;
                    },
                  ),
                ),
                Obx(
                  () => DropdownButtonFormField(
                    key: controller.key_dropdown,
                    value: controller.cityId.value,
                    items: state!
                        .map((state) => DropdownMenuItem<int>(
                            value: state.id,
                            child: Text(state.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal))))
                        .toList(),
                    onChanged: controller.changeCity,
                    decoration: const InputDecoration(
                      labelText: 'Cidade',
                      labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto'),
                    ),
                    hint: Text(
                      controller.cityController.value,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                  ),
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
                          style: button,
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
                            style: button,
                            child: const Text("Cancelar")),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
