import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/allDonationPet/controller.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:app_adota_fish/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class AllDonationPetPage extends GetView<AllDonationPetController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ADOTA FISH',
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  color: ColorsApp.appTitle)),
          backgroundColor: ColorsApp.appBackground,
          centerTitle: true,
          shape: const Border(
              bottom: BorderSide(color: ColorsApp.appBorder, width: 0.5)),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Routes.selectStatePet),
              icon: const Icon(Icons.location_pin),
              tooltip: 'Alterar o estado',
              color: Colors.white,
            )
          ],
        ),
        body: controller.obx(
          (state) => ListView(
            children: [
              for (var donation in state!)
                if ((donation != null))
                  if ((donation.clientDonor!.address.city.state != null))
                    Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 20),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      elevation: 4,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SizedBox(
                                  width: 400.0,
                                  height: 270.0,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                      child: FadeInImage.memoryNetwork(
                                          fit: BoxFit.fill,
                                          placeholder: kTransparentImage,
                                          image: donation.pet!.photo!)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 20, right: 20),
                              child: Text(
                                  "${donation.clientDonor!.address.city.name} / ${donation.clientDonor!.address.city.state?.name}",
                                  textAlign: TextAlign.left),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 20, right: 20),
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
                          const SizedBox(
                            height: 10,
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
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 5),
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
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, top: 5, bottom: 6),
                            child: SizedBox(
                              width: 140,
                              child: ElevatedButton(
                                onPressed: () => Get.toNamed(Routes.donationPet
                                    .replaceFirst(
                                        ':id', donation.id.toString())),
                                style: button,
                                child: const Text("Ver mais"),
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
