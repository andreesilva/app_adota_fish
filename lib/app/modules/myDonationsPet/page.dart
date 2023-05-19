import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/myDonationsPet/controller.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyDonationsPetPage extends GetView<MyDonationsPetController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MINHAS DOAÇÕES - PET',
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
          (state) => ListView(
            children: [
              for (var donation in state!)
                Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: SizedBox(
                                height: 285,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        donation.pet!.photo!,
                                        fit: BoxFit.fill,
                                        width: 400.0,
                                        height: 270.0,
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(
                                              top: 0,
                                              left: 6,
                                              right: 6,
                                              bottom: 10),
                                          child: SizedBox(
                                            width: double.infinity,
                                          )),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 5, left: 20),
                          child: Text("Espécie", textAlign: TextAlign.center),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 20),
                          child: Text(
                            donation.pet!.specie!.name!,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                color: Colors.black87),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
                          child:
                              Text("Quantidade", textAlign: TextAlign.center),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            donation.pet.amount.toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                color: Colors.black87),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                                    donation.pet.observation!,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 5, left: 15),
                              child: Icon(Icons.calendar_month,
                                  color: Colors.blueGrey),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 5),
                              child: Text(
                                'Publicado em ${DateFormat.yMd().format(donation.createdAt)}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (donation.status == 1) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: 80,
                                child: ElevatedButton(
                                  onPressed: () => showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Deseja realmente inativar este anúncio?"),
                                          titleTextStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          actionsOverflowButtonSpacing: 20,
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Não")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  controller.inactivatePet(
                                                      donation.id);
                                                },
                                                child: const Text("Sim")),
                                          ],
                                        );
                                      }),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  child: const Text("Inativar",
                                      style: TextStyle(fontSize: 13)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: 80,
                                child: ElevatedButton(
                                  onPressed: () => Get.toNamed(Routes.updatePet
                                      .replaceFirst(
                                          ':id', donation.id.toString())),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  child: const Text("Editar",
                                      style: TextStyle(fontSize: 13)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: 80,
                                child: ElevatedButton(
                                  onPressed: () => showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Deseja realmente excluir este anúncio?"),
                                          titleTextStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          actionsOverflowButtonSpacing: 20,
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Não")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  controller
                                                      .deletePet(donation.id);
                                                },
                                                child: const Text("Sim")),
                                          ],
                                        );
                                      }),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  child: const Text("Excluir",
                                      style: TextStyle(fontSize: 13)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ] else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: 80,
                                child: ElevatedButton(
                                  onPressed: () => showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Deseja realmente ativar este anúncio"),
                                          titleTextStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          actionsOverflowButtonSpacing: 20,
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Não")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  controller
                                                      .activatePet(donation.id);
                                                },
                                                child: const Text("Sim")),
                                          ],
                                        );
                                      }),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  child: const Text("Ativar"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: 80,
                                child: ElevatedButton(
                                  onPressed: () => showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Deseja realmente excluir este anúncio?"),
                                          titleTextStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          actionsOverflowButtonSpacing: 20,
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Não")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  controller
                                                      .deletePet(donation.id);
                                                },
                                                child: const Text("Sim")),
                                          ],
                                        );
                                      }),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  child: const Text("Excluir"),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextButton(
                          onPressed: () => Get.toNamed(Routes.dashboard),
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(
                              color: Colors.blueGrey,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
          onEmpty: Center(
            child: Text(
              "Você ainda não doou nenhum pet",
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyMedium?.copyWith(color: Colors.black),
            ),
          ),
        ));
  }
}
