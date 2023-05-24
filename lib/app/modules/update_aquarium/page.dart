import 'dart:io';
import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/register_pet/controller.dart';
import 'package:app_adota_fish/app/modules/update_aquarium/controller.dart';
import 'package:app_adota_fish/app/modules/update_pet/controller.dart';
import 'package:app_adota_fish/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_choices/search_choices.dart';

class UpdateAquariumPage extends GetView<UpdateAquariumController> {
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
    //print(controller.capacityIdController.value);
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('QUERO DOAR UM AQUÁRIO',
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
                            child: controller.isProficPicPath.value == true
                                ? Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.4, color: Colors.blueGrey),
                                    ),
                                    child: Image.file(File(
                                      controller.profilePicPath.value,
                                    )),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.4, color: Colors.blueGrey),
                                    ),
                                    child: Image.network(
                                        controller.photoAquarium))),
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
                                                takePhoto(
                                                    ImageSource.gallery,
                                                    controller
                                                        .aquariumIdController);
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
                                                takePhoto(
                                                    ImageSource.gallery,
                                                    controller
                                                        .aquariumIdController);
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
                  Obx(
                    () => DropdownButtonFormField(
                      value: controller.litrageId.value,
                      //value: controller.capacityIdController.value,

                      items: _valores
                          .asMap()
                          .entries
                          .map((litrage) => DropdownMenuItem<int>(
                              value: litrage.key, child: Text(litrage.value)))
                          .toList(),
                      onChanged: controller.changeLiterage,

                      hint: Text(
                        controller.capacity.value,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                      validator: (int? value) {
                        if (value == null) {
                          return 'Selecione a litragem';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    controller: controller.descriptionController,
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
                            style: button,
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

  Future<void> takePhoto(ImageSource source, int idAquarium) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);

    controller.setProfileImagePath(pickedFile!.path, idAquarium);

    Get.back();
  }
}
