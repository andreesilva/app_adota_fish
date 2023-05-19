import 'package:app_adota_fish/app/data/models/address.dart';
import 'package:app_adota_fish/app/data/models/city_full.dart';
import 'package:app_adota_fish/app/data/models/user_address_request.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/modules/user_address/repository.dart';
import 'package:app_adota_fish/app/widgets/message_general_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class UserAddressController extends GetxController
    with StateMixin<List<CityFullModel>> {
  final UserAddressRepository _repository;

  UserAddressController(this._repository);

  //String get stateName => '';

  final key_dropdown = GlobalKey<FormState>();

  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();
  var streetController = TextEditingController();
  var numberController = TextEditingController();
  var neighborhoodController = TextEditingController();
  var referenceController = TextEditingController();
  var complementController = TextEditingController();
  var cityController = "".obs;
  var stateController = "";
  var stateIdController = 0.obs;
  var cityIdController = 0.obs;
  final cityId = RxnInt();
  final _address = Rxn<AddressModel>();
  final stateId = RxnInt();

  final editing = RxBool(false);
  final loading = true.obs;

  var idCliente = 0;
  var idAddress = 0;

  var _clickedChangeState = 0.obs;

  final loadingCircular = ValueNotifier<bool>(false);

  @override
  void onInit() {
    _repository.getCitiesState(0).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      if ((error.toString() == 'Connection failed') ||
          (error.toString() == 'Network is unreachable') ||
          (error.toString() == 'Connection timed out')) {
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(const SnackBar(
          content: Text('Sem conexão de rede'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 15),
        ));
      } else {
        print(error.toString());
        //MessageGeneralError().showAlertErrorGeneral(QuickAlertType.error);
      }
    });

    fetchUser();

    super.onInit();
  }

  void fetchUser() {
    loading(true);

    _repository.getUser().then((data) {
      idCliente = data.id!;

      _repository.getClient(data.id!).then((data) {
        idAddress = data.address.id;
        streetController.text = data.address.street;
        numberController.text = data.address.number;
        neighborhoodController.text = data.address.neighborhood;
        referenceController.text = data.address.referencePoint!;
        complementController.text = data.address.complement!;
        cityController.value = data.address.city.name;
        stateController = data.address.city.state!.name;
        cityIdController.value = data.address.city.id;
        stateIdController.value = data.address.city.state!.id;
        loading(false);
      }, onError: (error) {
        loading(false);
      });

      loading(false);
    }, onError: (error) {
      loading(false);
    });
  }

  void showAlertSuccess(QuickAlertType quickAlertType) {
    QuickAlert.show(
      context: Get.context!,
      title: "",
      text: "Endereço atualizado com sucesso!",
      confirmBtnText: "Ok",
      type: quickAlertType,
      onConfirmBtnTap: () => Get.back(result: true),
    );
  }

  void showAlertError(QuickAlertType quickAlertType) {
    QuickAlert.show(
        context: Get.context!,
        title: "",
        text: "Não foi possível atualizar o seu endereço",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }

  void submit() {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (_clickedChangeState.value == 1) {
      var userAddressRequest = UserAddressRequestModel(
          id: idAddress,
          street: streetController.text,
          number: numberController.text,
          neighborhood: neighborhoodController.text,
          referencePoint: referenceController.text,
          cityId: cityId.value!,
          complement: complementController.text,
          clientId: idCliente);

      _updateAddress(userAddressRequest);
    } else {
      var userAddressRequest = UserAddressRequestModel(
          id: idAddress,
          street: streetController.text,
          number: numberController.text,
          neighborhood: neighborhoodController.text,
          referencePoint: referenceController.text,
          cityId: cityIdController.value,
          complement: complementController.text,
          clientId: idCliente);

      _updateAddress(userAddressRequest);
    }
  }

  void _updateAddress(UserAddressRequestModel userAddressRequest) {
    _repository.putAddress(userAddressRequest).then((value) {
      showAlertSuccess(QuickAlertType.success);
      loadingCircular.value = false;
    }, onError: (error) {
      print(error.toString());
      showAlertError(QuickAlertType.error);
      loadingCircular.value = false;
    });
  }

  void changeState(int? stateIdSelected) {
    loading(true);
    stateId.value = stateIdSelected;

    cityId.value = null;

    cityController.value = "";

    //Aqui é atribuído o valor um. Identificando que o cliente solicitou pra trocar de estado
    _clickedChangeState.value = 1;

    _repository.getCitiesState(stateIdSelected!).then((data) {
      loading(false);
      change(data, status: RxStatus.success());
    }, onError: (error) {
      loading(false);
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  void changeCity(int? cityIdSelected) {
    loading(true);

    cityId.value = cityIdSelected;

    key_dropdown.currentState?.reset();

    loading(false);
  }

  var currentPageIndex = 0.obs;
}
