//import 'dart:html';

import 'dart:io';

import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/photo_client/controller.dart';
import 'package:app_adota_fish/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoClientPage extends GetView<PhotoClientController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File? pickedFile;

  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: ColorsApp.appBackground,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 16.0),
          child: Expanded(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Obx(
                      () => Container(
                        child: Column(
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 81,
                                backgroundColor: Colors.blue,
                                child: CircleAvatar(
                                  backgroundImage:
                                      controller.isProficPicPath.value == true
                                          ? FileImage(File(controller
                                              .profilePicPath
                                              .value)) as ImageProvider
                                          : AssetImage("assets/Vector_1.png"),
                                  radius: 80,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 15,
                        child: InkWell(
                          child: const Icon(
                            Icons.add_a_photo,
                            color: Colors.black,
                          ),
                          onTap: () {
                            print("Clique na camera");
                            scaffoldKey.currentState!
                                .showBottomSheet((BuildContext context) {
                              Size size = MediaQuery.of(context).size;
                              return Container(
                                width: double.infinity,
                                height: size.height * 0.2,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                      fontWeight:
                                                          FontWeight.bold),
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Insira uma foto sua",
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () => {
                                        if (controller
                                            .profilePicPath.value.isNotEmpty)
                                          {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }),
                                          },
                                        controller.submit(),
                                      },
                                  style: button,
                                  child: const Text('Finalizar')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Future<void> takePhoto(ImageSource source) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);

    controller.setProfileImagePath(pickedFile!.path);

    Get.back();
  }
}
