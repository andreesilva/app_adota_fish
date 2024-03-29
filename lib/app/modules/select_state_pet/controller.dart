import 'package:app_adota_fish/app/data/models/state.dart';
import 'package:app_adota_fish/app/data/services/storage/service.dart';
import 'package:app_adota_fish/app/modules/select_state_pet/repository.dart';
import 'package:get/get.dart';

class SelectStatePetController extends GetxController with StateMixin<List<StateModel>> {

  final SelectStatePetRepository _repository;
  SelectStatePetController(this._repository);

   final _storageService = Get.find<StorageService>();

  @override
  void onInit() {
   
    super.onInit();
  }

  void onSelected(int idState) async {

    Get.offAllNamed('/pets/$idState');
    
  }
}