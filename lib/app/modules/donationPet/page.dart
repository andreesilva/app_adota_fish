import 'package:app_adota_fish/app/modules/donationPet/controller.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/src/material/badge.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DonationPetPage extends GetView<DonationPetController> {
  const DonationPetPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!controller.isLogged) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton(
            onPressed: () => Get.toNamed(Routes.login),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text('Entrar com a minha conta'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 55),
            child: Text('DETALHE DA DOAÇÃO',
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
            child: Column(children: [
              Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 400.0,
                          height: 270.0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: FadeInImage.memoryNetwork(
                                  fit: BoxFit.fill,
                                  placeholder: kTransparentImage,
                                  image: state!.pet!.photo!)),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: badges.Badge(
                            badgeStyle: const badges.BadgeStyle(
                              badgeColor: Colors.grey,
                              shape: badges.BadgeShape.square,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            //toAnimate: true,
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
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 20, bottom: 0),
                      child: Text(
                          "${state.clientDonor!.address.city.name} / ${state.clientDonor!.address.city.state!.name}",
                          textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
              Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 5, left: 20),
                            child: Text("Espécie", textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, left: 20),
                            child: Text(state.pet!.specie!.name!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                ),
                                textAlign: TextAlign.center),
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
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, left: 20),
                            child: Text(
                                "Quantidade: ${state.pet!.amount.toString()}",
                                textAlign: TextAlign.center),
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
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Padding(
                              padding: EdgeInsets.only(top: 5, left: 20),
                              child: Text("Observação",
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, left: 20),
                              child: Text(
                                state!.pet!.observation!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
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
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
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
