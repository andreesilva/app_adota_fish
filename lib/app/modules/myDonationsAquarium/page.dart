import 'package:app_adota_fish/app/modules/myDonationsAquarium/controller.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDonationsAquariumPage extends GetView<MyDonationsAquariumController> {
  const MyDonationsAquariumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(right: 55),
              child: Text('MINHAS DOAÇÕES - AQUÁRIO',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Roboto',
                  )),
            ),
          ),
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: SizedBox(
                                height: 195,
                                child: Column(
                                  children: [
                                    Image.network(donation.aquarium!.photo!,
                                        fit: BoxFit.fill,
                                        width: 400.0,
                                        height: 185.0),
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
                              )),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 5, left: 20),
                          child: Text('Capacidade'),
                        ),
                      ),
                      if (donation.aquarium.capacity! == 0) ...[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 5, left: 20),
                            child: Text(
                              "Acima de 200 litros",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                      ] else
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, left: 20),
                            child: Text(
                              "${donation.aquarium.capacity!} litros",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                              ),
                            ),
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
                                                  controller.inactivateAquarium(
                                                      donation.id);
                                                },
                                                child: const Text("Sim")),
                                          ],
                                        );
                                      }),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: const Text("Inativar"),
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
                                                  controller.deleteAquarium(
                                                      donation.id);
                                                },
                                                child: const Text("Sim")),
                                          ],
                                        );
                                      }),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: const Text("Excluir"),
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
                                                  controller.activateAquarium(
                                                      donation.id);
                                                },
                                                child: const Text("Sim")),
                                          ],
                                        );
                                      }),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
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
                                                  controller.deleteAquarium(
                                                      donation.id);
                                                },
                                                child: const Text("Sim")),
                                          ],
                                        );
                                      }),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
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
                          onPressed: () => Get.toNamed(
                                Routes.dashboard,
                              ),
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
              "Você ainda não doou nenhum aquário",
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyMedium?.copyWith(color: Colors.black),
            ),
          ),
        ));
  }
}
