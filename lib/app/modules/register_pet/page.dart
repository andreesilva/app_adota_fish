import 'dart:io';
import 'package:app_adota_fish/app/modules/register_pet/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_choices/search_choices.dart';

class RegistePetPage extends GetView<RegisterPetController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File? pickedFile;

  ImagePicker imagePicker = ImagePicker();

  final _valores = [
    'Selecione',
    'Água doce',
    'Água salgada',
  ];

  final _quatidade = [
    'Selecione',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(right: 55),
              child: Text('QUERO DOAR UM PET',
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
                    value: controller.typeWaterId.value,
                    items: _valores
                        .asMap()
                        .entries
                        .map((typeWater) => DropdownMenuItem<int>(
                            value: typeWater.key, child: Text(typeWater.value)))
                        .toList(),
                    onChanged: controller.changeTypeWater,
                    decoration: const InputDecoration(
                      labelText: 'Tipo da água',
                    ),
                    validator: (int? value) {
                      if (value == null) {
                        return 'Selecione o tipo da água';
                      }
                      return null;
                    },
                  ),
                  SearchChoices.single(
                    items: state!
                        .map((specie) => DropdownMenuItem<dynamic>(
                            value: specie.name, child: Text(specie.name)))
                        .toList(),
                    value: controller.changeSpecie,
                    hint: "Espécie",
                    searchHint: "Espécie",
                    onChanged: controller.changeSpecie,
                    isExpanded: true,
                  ),
                  DropdownButtonFormField(
                    value: controller.amountId.value,
                    items: _quatidade
                        .asMap()
                        .entries
                        .map((amount) => DropdownMenuItem<int>(
                            value: amount.key, child: Text(amount.value)))
                        .toList(),
                    onChanged: controller.changeAmount,
                    decoration: const InputDecoration(
                      labelText: 'Quantidade',
                    ),
                    validator: (int? value) {
                      if (value == null) {
                        return 'Selecione o quantidade';
                      }
                      return null;
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    controller: controller.observationController,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto',
                    ),
                    decoration: const InputDecoration(
                        hintText:
                            "Adicione aqui informaçõs adicionais sobre o seu animal",
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
