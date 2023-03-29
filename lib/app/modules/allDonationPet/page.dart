import 'package:app_adota_fish/app/modules/allDonationPet/controller.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllDonationPetPage extends GetView<AllDonationPetController> {
  @override
  Widget build(BuildContext context) {
    int i = 0;
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
            onPressed: () => Get.toNamed(Routes.selectState),
            icon: const Icon(Icons.location_pin),
            tooltip: 'Alterar cidade',
            color: Colors.blueAccent,
          )
        ],
        ),
        body: controller.obx(
          (state) => ListView(
            children: [
              for (var donation in state!)

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
                              child: Container(
                                height: 195,
                                child: Column(
                                  children: [
                                    Image.network(donation.pet!.photo!,
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
                              "${donation.clientDonor!.address.city.name} / ${donation.clientDonor!.address.city.state?.name}",
                              textAlign: TextAlign.center),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 20),
                          child: Text(
                            donation.pet!.specie!.name!,
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
                            onPressed: () => Get.toNamed(Routes.donationPet
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
              "Ainda não há nenhum anúncio publicado",
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyMedium?.copyWith(color: Colors.black),
            ),
          ),
        ));
  }
}
