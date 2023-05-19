import 'dart:io';
import 'package:app_adota_fish/app/core/theme/colors.app.dart';
import 'package:app_adota_fish/app/modules/option_donation/controller.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:giff_dialog/giff_dialog.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionDonationPage extends GetView<OptionDonationController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('ADOTA FISH',
            style: TextStyle(
                fontSize: 17, fontFamily: 'Roboto', color: ColorsApp.appTitle)),
        centerTitle: true,
        backgroundColor: ColorsApp.appBackground,
        shape: const Border(
            bottom: BorderSide(color: ColorsApp.appBorder, width: 0.5)),
      ),
      body: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        content: SizedBox(
            width: double.maxFinite,
            height: 170,
            child: ListView(
              padding: const EdgeInsets.all(5),
              children: <Widget>[
                ListTile(
                  title: const Center(
                      child: Text("QUERO DOAR:",
                          style: TextStyle(
                              fontSize: 27,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto'))),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.crop_5_4, color: Colors.blue[800]),
                  title: const Center(child: Text("AQUÁRIO")),
                  onTap: () {
                    Get.toNamed(Routes.registerAquarium);
                  },
                ),
                ListTile(
                  leading:
                      FaIcon(FontAwesomeIcons.fish, color: Colors.blue[800]),
                  title: const Center(child: Text("PET")),
                  onTap: () {
                    Get.toNamed(Routes.registerPet);
                  },
                ),
              ],
            )),
      ),
    );
  }
}
