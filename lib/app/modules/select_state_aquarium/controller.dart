import 'package:app_adota_fish/app/data/models/state.dart';
import 'package:app_adota_fish/app/data/services/storage/service.dart';
import 'package:app_adota_fish/app/modules/select_state_aquarium/repository.dart';
import 'package:get/get.dart';

class SelectStateAquariumController extends GetxController with StateMixin<List<StateModel>> {

  final SelectStateAquariumRepository _repository;
  SelectStateAquariumController(this._repository);

   final _storageService = Get.find<StorageService>();

  @override
  void onInit() {
   
    super.onInit();
  }

  void onSelected(int idState) async {

    Get.offAllNamed('/pets/$idState');
    
  }
}