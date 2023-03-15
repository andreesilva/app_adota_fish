import 'package:app_adota_fish/app/modules/user_address/controller.dart';
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 55),
            child: Text('EDITAR ENDEREÇO',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                )),
          ),
        ),
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
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'informe um ponto de referência para o entregador';
                    }
                    return null;
                  },
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
                  decoration:
                      const InputDecoration(labelText: 'Selecione um estado'),
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
                    labelText: 'Selecione uma cidade',
                  ),
                  validator: (int? value) {
                    if (value == null) {
                      return 'Selecione uma cidade';
                    }
                    return null;
                  },
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
                            child: const Text("Salvar")),
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
      ),
    );
  }
}
