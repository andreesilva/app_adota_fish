import 'dart:io';

import 'package:app_adota_fish/app/modules/register_aquarium/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterAquariumPage extends GetView<RegisterAquariumController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File? pickedFile;

  ImagePicker imagePicker = ImagePicker();

  final _valores = [
    'Selecione a capacidade',
    '10',
    '25',
    '50',
    '72',
    '100',
    '200',
    'Acima de 200'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(right: 55),
              child: Text('QUERO DOAR UM AQUÁRIO',
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
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Obx(() => Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 180,
                            //color: Colors.grey[300],
                            child: controller.isProficPicPath.value == true
                                ? Image.file(File(
                                    controller.profilePicPath.value,
                                  ))
                                : const Text('Insira uma foto do aquário'),
                          )),
                      Positioned(
                          bottom: 40,
                          child: InkWell(
                            child: const Icon(
                              Icons.add_a_photo,
                              color: Colors.blueAccent,
                              size: 34.0,
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
                  DropdownButtonFormField(
                    value: controller.litrageId.value,
                    items: _valores
                        .asMap()
                        .entries
                        .map((litrage) => DropdownMenuItem<int>(
                            value: litrage.key, child: Text(litrage.value)))
                        .toList(),
                    onChanged: controller.changeLiterage,
                    decoration: const InputDecoration(
                      labelText: 'Litragem do aqúario',
                    ),
                    validator: (int? value) {
                      if (value == null) {
                        return 'Selecione a litragem';
                      }
                      return null;
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    controller: controller.descriptionController,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto',
                    ),
                    decoration: const InputDecoration(
                        hintText:
                            "Descreva aqui informações adicionais se tiver sobre o aquário. Informe aqui também equipamentos, acessórios, elementos que queira doar junto com o aquário. Exemplo: filtro, iluminação, rochas, etc.",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey))),
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
                            child: const Text('Publicar anúncio'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> takePhoto(ImageSource source) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);

    controller.setProfileImagePath(pickedFile!.path);

    Get.back();
  }
}
