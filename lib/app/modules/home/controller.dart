import 'package:app_adota_fish/app/data/models/donations_aquarium.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/home/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with StateMixin<List<DonationAquariumModel>> {
  HomeRepository _repository;

  HomeController(this._repository);

  final _authService = Get.find<AuthService>();

  bool get isLogged => _authService.isLogged;

  final loading = true.obs;

  @override
  void onInit() {
    loading(true);

    int id = 0;
  
    if(Get.parameters.isNotEmpty){
        
        id = int.parse(Get.parameters["id"]!);
    }

    _repository.getDonations(id).then((data) {
      print(data);
      print("pulo aquario");
      if (data.isEmpty) {
        print("Msg aquario 1");
        change([], status: RxStatus.empty());
      } else {
        print("Msg aquario 2");
        change(data.cast<DonationAquariumModel>(), status: RxStatus.success());
      }
    }, onError: (error) {
      print("Msg aquario 3");
      print(error);
      
     if(error.toString() == 'Connection failed'){
        
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
         const SnackBar(content: Text('Sem conexão de rede'),backgroundColor: Colors.red, duration: Duration(seconds: 300 ),)
        );
     } else{
        change(null, status: RxStatus.error(error.toString()));
     }
    });

    super.onInit();
  }
}
