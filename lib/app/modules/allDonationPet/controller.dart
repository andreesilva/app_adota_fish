import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/allDonationPet/repository.dart';
import 'package:get/get.dart';

class AllDonationPetController extends GetxController
    with StateMixin<List<DonationPetModel>> {
  AllDonationPetRepository _repository;

  AllDonationPetController(this._repository);

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

    _repository.getDonationsPets(id).then((data) {
      
      if (data.isEmpty) {
        print("Msg 1");
        change([], status: RxStatus.empty());
      } else {
        print("Msg 2");
        change(data, status: RxStatus.success());
      }
    }, onError: (error) {
      print("Msg 3");
      print(error.toString());
      change(null, status: RxStatus.error(error.toString()));
    });

    super.onInit();
  }
}
