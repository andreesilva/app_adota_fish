import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/about/controller.dart';
import 'package:app_adota_fish/app/modules/user_profile/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masked_text_field/masked_text_field.dart';

class AboutPage extends GetView<AboutController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOBRE O ADOTA FISH',
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
          child: Column(
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "O Adota Fish é um aplicativo onde tanto quem adota ou quem quer doar um animal aquático ornalmental ou um aquario, pode utilizar.",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Se você possui animal ou aquário para adoção basta criar uma publicação com os detalhes do mesmo e esperar algúem entrar em contato.",
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "O Adota Fish tem como objetivo encontrar um novo lar para pet's aquáticos ornamentais, que por algum motivo não podem ficar mas sob os cuidados de seus atuais donos.",
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                      ),
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
