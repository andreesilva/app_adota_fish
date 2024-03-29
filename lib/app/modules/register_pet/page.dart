import 'dart:io';
import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/register_pet/controller.dart';
import 'package:app_adota_fish/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Utilities/Validator.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_choices/search_choices.dart';
import 'package:searchfield/searchfield.dart';

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
    //final  suggestions = controller.state!
    //                      .map((specie) => DropdownMenuItem<dynamic>(
    //                        value: specie.name, child: Text(specie.name)))
    //                  .toList();
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('QUERO DOAR UM PET',
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  color: ColorsApp.appTitle)),
          centerTitle: true,
          backgroundColor: ColorsApp.appBackground,
          shape: const Border(
              bottom: BorderSide(color: ColorsApp.appBorder, width: 0.5)),
        ),
        body: controller.obx(
          (state) => SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 17.0, horizontal: 16.0),
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
                            child: controller.isProficPicPath.value == true
                                ? Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.5, color: Colors.blueGrey),
                                      ),
                                      child: Image.file(File(
                                        controller.profilePicPath.value,
                                      )),
                                    ),
                                    elevation: 7,
                                    shadowColor: Colors.blueGrey,
                                  )
                                : const Text(
                                    'Insira uma foto do pet',
                                    style: TextStyle(color: Colors.red),
                                  ),
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
                      labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto'),
                    ),
                    validator: (int? value) {
                      if (value == null) {
                        return 'Selecione o tipo da água';
                      }
                      return null;
                    },
                  ),
                  SearchChoices.single(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    items: state!
                        .map((specie) => DropdownMenuItem<dynamic>(
                            value: specie.name, child: Text(specie.name)))
                        .toList(),
                    value: controller.changeSpecie,
                    hint: "Espécie",
                    displayClearIcon: false,
                    closeButton: "Fechar",
                    searchHint: "Espécie",
                    onChanged: controller.changeSpecie,
                    isExpanded: true,
                    validator: (dynamic value) {
                      if (value == null || value.isEmpty) {
                        return 'Selecione a espécie após o tipo da água';
                      }
                      return null;
                    },
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
                      labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto'),
                    ),
                    validator: (int? value) {
                      if (value == null) {
                        return 'Selecione a quantidade';
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
                            onPressed: () => {
                              if ((controller.formKey.currentState!
                                      .validate()) &&
                                  (controller.profilePicPath.value.isNotEmpty))
                                {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }),
                                },
                              controller.submit(),
                            },
                            style: button,
                            child: const Text('Publicar anúncio'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              style: button,
                              child: const Text("Cancelar")),
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
    final pickedImage = await controller.imageHelper.pickImage(source: source);

    final croppedFile = await controller.imageHelper
        .crop(file: pickedImage.first, cropStyle: CropStyle.rectangle);

    controller.setProfileImagePath(croppedFile!.path);

    Get.back();
  }
}
