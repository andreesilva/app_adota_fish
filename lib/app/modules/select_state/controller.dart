import 'package:app_adota_fish/app/data/models/city.dart';
import 'package:app_adota_fish/app/data/models/state.dart';
import 'package:app_adota_fish/app/data/services/storage/service.dart';
import 'package:app_adota_fish/app/modules/select_state/repository.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:get/get.dart';

class SelectStateController extends GetxController with StateMixin<List<StateModel>> {

  final SelectStateRepository _repository;
  SelectStateController(this._repository);

   final _storageService = Get.find<StorageService>();

  @override
  void onInit() {
   
    super.onInit();
  }

  void onSelected(int idState) async {

    Get.offAllNamed('/pets/$idState');
    
  }
}