import 'dart:io';
import 'package:app_adota_fish/app/modules/account/controller.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountPage extends GetView<AccountController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File? pickedFile;

  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Center(
          child: Text('MINHA CONTA',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
              )),
        ),
      ),
      body: ListView(children: [
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Obx(() => Container(
                      child: Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 81,
                              backgroundColor: Colors.blue,
                              child: CircleAvatar(
                                backgroundImage: controller
                                            .isProficPicPath.value ==
                                        true
                                    ? FileImage(
                                        File(controller.profilePicPath.value),
                                      ) as ImageProvider
                                    : NetworkImage(controller.photoClient),
                                radius: 80,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                    bottom: 5,
                    child: InkWell(
                      child: const Icon(
                        Icons.add_a_photo,
                        color: Colors.blueAccent,
                      ),
                      onTap: () {
                        print("Clique na camera");
                        scaffoldKey.currentState!
                            .showBottomSheet((BuildContext context) {
                          Size size = MediaQuery.of(context).size;
                          return Container(
                            //color: Colors.grey,
                            width: double.infinity,
                            height: size.height * 0.2,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.image),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Galeria",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        onTap: () {
                                          takePhoto(ImageSource.gallery);
                                        }),
                                    const SizedBox(
                                      width: 80,
                                    ),
                                    InkWell(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.add_a_photo),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Camera",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        onTap: () {
                                          takePhoto(ImageSource.camera);
                                        }),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                      },
                    )),
              ],
            ),

            // ignore: prefer_const_constructors
            SizedBox(
              height: 40,
            ),
          ],
        ),
        ListTile(
          leading: Icon(Icons.person, color: Colors.blue[800]),
          title: const Text("Dados pessoais"),
          onTap: () {
            Get.toNamed(Routes.userProfile);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.house,
            color: Colors.blue[800],
          ),
          title: const Text("Endereço"),
          onTap: () {
            Get.toNamed(Routes.userAddress, arguments: controller.address);
          },
        ),
        ListTile(
          leading: Icon(Icons.lock, color: Colors.blue[800]),
          title: const Text("Alterar senha"),
          onTap: () {
            Get.toNamed(Routes.userPassword);
          },
        ),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.handHoldingHeart,
              color: Colors.blue[800]),
          title: const Text("Minhas doações"),
          onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  content: SizedBox(
                      width: double.minPositive,
                      height: 170,
                      child: ListView(
                        padding: const EdgeInsets.all(5),
                        children: <Widget>[
                          const ListTile(
                            title: Center(
                                child: Text("SELECIONE:",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto',
                                    ))),
                          ),
                          ListTile(
                            leading:
                                Icon(Icons.crop_5_4, color: Colors.blue[800]),
                            title: const Center(child: Text("Aquário")),
                            onTap: () {
                              Get.toNamed(Routes.myDonationsAquarium);
                            },
                          ),
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.fish,
                                color: Colors.blue[800]),
                            title: const Center(child: Text("Pet")),
                            onTap: () {
                              Get.toNamed(Routes.myDonationsPet);
                            },
                          ),
                        ],
                      )),
                );
              }),
        ),
        const SizedBox(
          height: 25,
        ),
        ListTile(
          leading: const Icon(Icons.arrow_back, color: Colors.red),
          title: const Text("Sair da minha conta"),
          onTap: () => showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Deseja realmente sair do aplicativo?"),
                  titleTextStyle:
                      const TextStyle(color: Colors.black, fontSize: 16),
                  actionsOverflowButtonSpacing: 20,
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Não")),
                    ElevatedButton(
                        onPressed: () {
                          controller.logout();
                        },
                        child: const Text("Sim")),
                  ],
                );
              }),
        ),
      ]),
    );
  }

  Future<void> takePhoto(ImageSource source) async {
    final pickedImage =  await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);

    controller.setProfileImagePath(pickedFile!.path);

    Get.back();
  }
}
