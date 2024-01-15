import 'dart:async';

import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/data/services/storage/service.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  final _authService = Get.find<AuthService>();
 
  final _storageService = Get.find<StorageService>();
 
 @override
 void onReady() {
    super.onReady();

      loading();
  }

  Future<void> loading() async {

    if (_storageService.token != null) {
      
      Get.offAllNamed(Routes.dashboard);
    }else{
      Timer(const Duration(seconds: 5), () {
        Get.offAndToNamed(Routes.dashboard);
      });
    }
  }
  }
