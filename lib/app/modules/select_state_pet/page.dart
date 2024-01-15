import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/select_state_pet/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectStatePetPage extends GetView<SelectStatePetController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SELECIONE UM ESTADO',
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  color: ColorsApp.appTitle)),
          centerTitle: true,
          backgroundColor: ColorsApp.appBackground,
          shape: const Border(
              bottom: BorderSide(color: ColorsApp.appBorder, width: 0.5)),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            ListTile(
              title: const Text(
                'Todos',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(0),
            ),
            ListTile(
              title: const Text(
                'Acré',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(1),
            ),
            ListTile(
              title: const Text(
                'Alagoas',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(2),
            ),
            ListTile(
              title: const Text(
                'Amazonas',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(3),
            ),
            ListTile(
              title: const Text(
                'Amapá',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(4),
            ),
            ListTile(
              title: const Text(
                'Bahia',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(5),
            ),
            ListTile(
              title: const Text(
                'Ceará',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(6),
            ),
            ListTile(
              title: const Text(
                'Distrito Federal',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(7),
            ),
            ListTile(
              title: const Text(
                'Espírito Santo',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(8),
            ),
            ListTile(
              title: const Text(
                'Goiás',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(9),
            ),
            ListTile(
              title: const Text(
                'Maranhão',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(10),
            ),
            ListTile(
              title: const Text(
                'Minas Gerais',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(11),
            ),
            ListTile(
              title: const Text(
                'Mato Grosso do Sul',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(12),
            ),
            ListTile(
              title: const Text(
                'Mato Grosso',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(13),
            ),
            ListTile(
              title: const Text(
                'Pará',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(14),
            ),
            ListTile(
              title: const Text(
                'Paraíba',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(15),
            ),
            ListTile(
              title: const Text(
                'Pernambuco',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(16),
            ),
            ListTile(
              title: const Text(
                'Piauí',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(17),
            ),
            ListTile(
              title: const Text(
                'Paraná',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(18),
            ),
            ListTile(
              title: const Text(
                'Rio de Janeiro',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(19),
            ),
            ListTile(
              title: const Text(
                'Rio Grande do Norte',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(20),
            ),
            ListTile(
              title: const Text(
                'Rondônia',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(21),
            ),
            ListTile(
              title: const Text(
                'Roraima',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(22),
            ),
            ListTile(
              title: const Text(
                'Rio Grande do Sul',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(23),
            ),
            ListTile(
              title: const Text(
                'Santa Catarina',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(24),
            ),
            ListTile(
              title: const Text(
                'Sergipe',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(25),
            ),
            ListTile(
              title: const Text(
                'São Paulo',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(26),
            ),
            ListTile(
              title: const Text(
                'Tocantins',
                textAlign: TextAlign.center,
              ),
              onTap: () => controller.onSelected(27),
            ),
          ],
        )));
  }
}
