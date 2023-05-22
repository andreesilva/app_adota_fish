import 'dart:io';
import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/register_pet/controller.dart';
import 'package:app_adota_fish/app/modules/update_pet/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_choices/search_choices.dart';

class UpdatePetPage extends GetView<UpdatePetController> {
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

  var nameTypeWater = '';

  @override
  Widget build(BuildContext context) {
    if (controller.watherIdController == 1) {
      nameTypeWater = "Água doce";
    } else {
      nameTypeWater = "Água salgada";
    }
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('EDITAR ANÚNCIO',
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
                      Obx(
                        () => Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 180,
                            //color: Colors.grey[300],
                            child: controller.isProficPicPath.value == true
                                ? Image.file(File(
                                    controller.profilePicPath.value,
                                  ))
                                : Image.network(controller.photoPet)),
                      ),
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
                                                takePhoto(ImageSource.gallery,
                                                    controller.petIdController);
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
                                                takePhoto(ImageSource.camera,
                                                    controller.petIdController);
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
                    value: controller.watherIdController.value,
                    items: _valores
                        .asMap()
                        .entries
                        .map((typeWater) => DropdownMenuItem<int>(
                            value: typeWater.key,
                            child: Text(typeWater.value,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal))))
                        .toList(),
                    onChanged: controller.changeTypeWater,
                    hint: Text(
                      nameTypeWater,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    validator: (int? value) {
                      if (value == null) {
                        return 'Selecione o tipo da água';
                      }
                      return null;
                    },
                  ),
                  SearchChoices.single(
                    key: controller.key_dropdown,
                    items: state?.state2!
                        .map((specie) => DropdownMenuItem<dynamic>(
                            value: specie.name, child: Text(specie.name)))
                        .toList(),
                    value: controller.changeSpecie,
                    hint: Text(
                      controller.specieController,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
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
                    hint: Text(
                      controller.amountIdController.toString(),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    validator: (int? value) {
                      if (value == null) {
                        return 'Selecione o quantidade';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    controller: controller.observationController,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
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
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            child: const Text('Editar anúncio'),
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

  Future<void> takePhoto(ImageSource source, int idPet) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);

    controller.setProfileImagePath(pickedFile!.path, idPet);

    Get.back();
  }
}
