import 'package:app_adota_fish/app/modules/account/page.dart';
import 'package:app_adota_fish/app/modules/allDonationPet/page.dart';
import 'package:app_adota_fish/app/modules/dashboard/controller.dart';
import 'package:app_adota_fish/app/modules/home/page.dart';
import 'package:app_adota_fish/app/modules/login/page.dart';
import 'package:app_adota_fish/app/modules/option_donation/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx((() => NavigationBar(
                onDestinationSelected: controller.changePageIndex,
                selectedIndex: controller.currentPageIndex.value,
                destinations: [
                  const NavigationDestination(
                      icon:
                          FaIcon(FontAwesomeIcons.fish, color: Colors.blueGrey),
                      label: "Pets",
                      selectedIcon: FaIcon(FontAwesomeIcons.fish,
                          color: Colors.blueAccent)),
                  const NavigationDestination(
                    icon: Icon(Icons.crop_5_4, color: Colors.blueGrey),
                    label: "Aquários",
                    selectedIcon:
                        Icon(Icons.crop_5_4, color: Colors.blueAccent),
                  ),
                  if (controller.isLogged)
                    const NavigationDestination(
                      icon: FaIcon(FontAwesomeIcons.handHoldingHeart,
                          color: Colors.blueGrey),
                      label: "Doar",
                      selectedIcon: FaIcon(FontAwesomeIcons.handHoldingHeart,
                          color: Colors.blueAccent),
                    ),
                  if (controller.isLogged) ...[
                    const NavigationDestination(
                      icon: Icon(Icons.person, color: Colors.blueGrey),
                      label: "Minha conta",
                      selectedIcon:
                          Icon(Icons.person, color: Colors.blueAccent),
                    ),
                  ] else
                    const NavigationDestination(
                      icon: Icon(Icons.person, color: Colors.blueGrey),
                      label: "Acessar",
                      selectedIcon:
                          Icon(Icons.person, color: Colors.blueAccent),
                    ),
                ]))),
        body: Obx(
          () => IndexedStack(
            index: controller.currentPageIndex.value,
            children: [
              AllDonationPetPage(),
              HomePage(),
              if (controller.isLogged) OptionDonationPage(),
              if (controller.isLogged) ...[AccountPage()] else LoginPage()
            ],
          ),
        ));
  }
}
