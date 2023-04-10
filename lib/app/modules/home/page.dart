import 'package:app_adota_fish/app/modules/home/controller.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  int number = 0;

  @override
  Widget build(BuildContext context) {
    String uppercaseLetters = "";
    
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('ADOTA FISH',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                )),
          ),
           actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.selectStateAquarium),
            icon: const Icon(Icons.location_pin),
            tooltip: 'Alterar o estado',
            color: Colors.blueAccent,
          )
        ],
        ),
        body: controller.obx(
          
          (state) => 
          
          ListView(
            children: [
              for (var donation in state!)
              
              if((donation != null))
              if((donation.clientDonor.address.city.state != null))
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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 20),
                          child: Text(
                              "${donation.clientDonor!.address.city.name} / ${donation.clientDonor!.address.city.state!.name}",
                              textAlign: TextAlign.center),
                        ),
                      ),
                      if (donation.aquarium!.capacity! == 0) ...[
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
                              "${donation.aquarium!.capacity!} litros",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 205, top: 5),
                        child: SizedBox(
                          width: 140,
                          child: ElevatedButton(
                            onPressed: () => Get.toNamed(Routes.donationAquarium
                                .replaceFirst(':id', donation.id.toString())),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text("Ver Mais >>"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          onEmpty: Center(
            child: Text(
              "Não há nenhum anúncio publicado",
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyMedium?.copyWith(color: Colors.black),
            ),
          ),
        ));
  }
}
