import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/donationPet/controller.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:app_adota_fish/app/widgets/button.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/src/material/badge.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DonationPetPage extends GetView<DonationPetController> {
  const DonationPetPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!controller.isLogged) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ADOTA FISH',
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  color: ColorsApp.appTitle)),
          centerTitle: true,
          backgroundColor: ColorsApp.appBackground,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => Get.toNamed(Routes.login),
            style: button,
            child: const Text('Entrar com a minha conta'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETALHE DA DOAÇÃO',
            style: TextStyle(
                fontSize: 17, fontFamily: 'Roboto', color: ColorsApp.appTitle)),
        centerTitle: true,
        backgroundColor: ColorsApp.appBackground,
        shape: const Border(
            bottom: BorderSide(color: ColorsApp.appBorder, width: 0.5)),
      ),
      body: controller.obx(
        (state) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            child: Column(children: [
              Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                elevation: 4,
                shadowColor: Colors.blueGrey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              width: 400.0,
                              height: 270,
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                  child: FadeInImage.memoryNetwork(
                                      fit: BoxFit.fill,
                                      placeholder: kTransparentImage,
                                      image: state!.pet!.photo!)),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: badges.Badge(
                            badgeStyle: const badges.BadgeStyle(
                              badgeColor: ColorsApp.advertiserName,
                              shape: badges.BadgeShape.square,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(2),
                                  topLeft: Radius.circular(3),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(3)),
                            ),
                            badgeContent: Text(
                              "Anunciante: ${state!.clientDonor!.name}",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 22, bottom: 0, right: 20),
                        child: Text(
                            "${state.clientDonor!.address.city.name} / ${state.clientDonor!.address.city.state!.name}",
                            textAlign: TextAlign.left),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5, left: 20),
                    child: Icon(Icons.calendar_month, color: Colors.blueGrey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 5),
                    child: Text(
                      'Publicado em ${DateFormat.yMd().format(state.createdAt)}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                  side: const BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                elevation: 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Padding(
                            padding:
                                EdgeInsets.only(top: 5, left: 20, right: 20),
                            child: Text("Espécie", textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, left: 20),
                              child: Text(state.pet!.specie!.name!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                  ),
                                  textAlign: TextAlign.left),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 175, top: 5),
                    ),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                  side: const BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                elevation: 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 5, left: 20, right: 20),
                            child: Text(
                                "Quantidade: ${state.pet!.amount.toString()}",
                                textAlign: TextAlign.left),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 175, top: 5),
                    ),
                  ],
                ),
              ),
              if (state.pet!.observation!.isNotEmpty)
                Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                  elevation: 4,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Padding(
                                padding: EdgeInsets.only(top: 5, left: 20),
                                child: Text(
                                  "Observação",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ]),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 20, right: 20),
                                child: Expanded(
                                  child: Text(
                                    state!.pet!.observation!,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 175, top: 5),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () => {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text("INFORMAÇÕES DE CONTATO",
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.red,
                                          fontSize: 17.0,
                                          fontFamily: 'Roboto'))),
                            ),
                            ListTile(
                              leading: const FaIcon(FontAwesomeIcons.whatsapp),
                              title: Text(state.clientDonor!.phone),
                              onTap: () =>
                                  openWhatsApp(state.clientDonor!.phone),
                            ),
                            ListTile(
                                leading: const Icon(Icons.mail),
                                title: Text(state.clientDonor!.user.email),
                                onTap: () async {
                                  String email =
                                      state.clientDonor!.user.email.toString();
                                  String subject = "Adoção de pet aquático";
                                  String body = "";

                                  String? encodeQueryParameters(
                                      Map<String, String> params) {
                                    return params.entries
                                        .map((e) =>
                                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }

                                  final Uri emaillUri = Uri(
                                    scheme: 'mailto',
                                    path: email,
                                    query:
                                        encodeQueryParameters(<String, String>{
                                      'subject': subject,
                                      'body': body
                                    }),
                                  );
                                  // ignore: deprecated_member_use
                                  launch(emaillUri.toString());
                                }),
                          ],
                        );
                      },
                    )
                  },
                  style: button,
                  child: const Text("Quero adotar esse pet"),
                ),
              )
            ])),
      ),
    );
  }

  openWhatsApp(phone) {
    return launchUrl(
      Uri.parse(
        'whatsapp://send?phone=+55$phone&text=Olá, vi o anúncio no Adota Fish, e gostaria de adotar esse pet.', //put your number here
      ),
    );
  }
}
