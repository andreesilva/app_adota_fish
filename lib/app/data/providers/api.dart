import 'dart:convert';

import 'package:app_adota_fish/app/data/models/address.dart';
import 'package:app_adota_fish/app/data/models/aquarium.dart';
import 'package:app_adota_fish/app/data/models/aquarium_request.dart';
import 'package:app_adota_fish/app/data/models/city.dart';
import 'package:app_adota_fish/app/data/models/city_full.dart';
import 'package:app_adota_fish/app/data/models/client.dart';
import 'package:app_adota_fish/app/data/models/donations_aquarium.dart';
import 'package:app_adota_fish/app/data/models/donations_pet.dart';
import 'package:app_adota_fish/app/data/models/specie_request.dart';
import 'package:app_adota_fish/app/data/models/forgot_password_request.dart';
import 'package:app_adota_fish/app/data/models/forgot_password_response.dart';
import 'package:app_adota_fish/app/data/models/password.dart';
import 'package:app_adota_fish/app/data/models/pet.dart';
import 'package:app_adota_fish/app/data/models/pet_request.dart';
import 'package:app_adota_fish/app/data/models/photo_client_request.dart';
import 'package:app_adota_fish/app/data/models/specie.dart';
import 'package:app_adota_fish/app/data/models/state.dart';
import 'package:app_adota_fish/app/data/models/user.dart';
import 'package:app_adota_fish/app/data/models/user_address_request.dart';
import 'package:app_adota_fish/app/data/models/user_login_request.dart';
import 'package:app_adota_fish/app/data/models/user_login_response.dart';
import 'package:app_adota_fish/app/data/models/user_profile_request.dart';
import 'package:app_adota_fish/app/data/services/storage/service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {
  final _storageService = Get.find<StorageService>();

  final firebaseFolderOcc = "MEDIAS/occurrences/tech";
  final firebaseFolder = "TECHWEB";

  @override
  void onInit() {
    //Local
    httpClient.baseUrl = "http://10.0.0.230:3333/";
    //httpClient.baseUrl = "http://192.168.234.19:3333/";

    //Produção
    //httpClient.baseUrl = "http://52.67.106.1:3333/";

    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';

      return request;
    });

    httpClient.addAuthenticator((Request request) {
      var token = _storageService.token;
      var headers = {'Authorization': 'Bearer $token'};

      request.headers.addAll(headers);

      return request;
    });

    super.onInit();
  }

  Future<List<CityModel>> getCities() async {
    var response = _errorHandler(await get('cidades'));

    List<CityModel> data = [];

    for (var city in response.body) {
      data.add(CityModel.from(city));
    }

    return data;
  }

  Future<List<CityFullModel>> getCitiesState(int id) async {
    var response = _errorHandler(await get('cidades/$id'));

    List<CityFullModel> data = [];

    for (var city in response.body) {
      data.add(CityFullModel.from(city));
    }
    return data;
  }

  Future<List<SpecieModel>> getSpecies(int id) async {
    var response = _errorHandler(await get('especie/$id'));

    List<SpecieModel> data = [];

    for (var city in response.body) {
      data.add(SpecieModel.fromJson(city));
    }
    return data;
  }

  Future<List<StateModel>> getStates() async {
    var response = _errorHandler(await get('estados'));

    List<StateModel> data = [];

    print("${response.bodyString} estados");

    for (var state in response.body) {
      data.add(StateModel.from(state));
    }
    return data;
  }

  Future<UserLoginResponseModel> login(UserLoginRequestModel data) async {
    var response = _errorHandler(await post('login', jsonEncode(data)));

    print("${response.bodyString} login");

    return UserLoginResponseModel.fromJson(response.body);
  }

  Future<ForgotPasswordResponseModel> forgotPassword(
      ForgotPasswordRequestModel data) async {
    var response =
        _errorHandler(await post('forgot-password', jsonEncode(data)));

    print("${response.bodyString} forgot-password");

    return ForgotPasswordResponseModel.fromJson(response.body);
  }

  Future<UserModel> register(UserProfileRequestModel data) async {
    var response =
        _errorHandler(await post('cliente/cadastro', jsonEncode(data)));

    print(UserModel.fromJson(response.body));

    return UserModel.fromJson(response.body);
  }

  Future<AquariumModel> registerAquarium(AquariumRequestModel data) async {
    var response =
        _errorHandler(await post('doacao/cadastro-aquario', jsonEncode(data)));

    print(AquariumModel.fromJson(response.body));

    return AquariumModel.fromJson(response.body);
  }

  Future<PetModel> registerPet(PetRequestModel data) async {
    var response =
        _errorHandler(await post('doacao/cadastro-pet', jsonEncode(data)));

    print("Cadastro pet");
    print(PetModel.fromJson(response.body));

    return PetModel.fromJson(response.body);
  }

  Future<void> putPhotoClient(PhotoClientRequestModel data) async {
    _errorHandler(await put('cliente/foto', jsonEncode(data)));
  }

  Future<UserModel> getUser() async {
    var response = _errorHandler(await get('auth/me'));

    print("${response.bodyString} getUser");

    return UserModel.fromJson(response.body);
  }

  Future<UserModel> putUser(UserProfileRequestModel data) async {
    var response = _errorHandler(await put('cliente/editar', jsonEncode(data)));

    return UserModel.fromJson(response.body);
  }

  Future<void> putPassword(PasswordModel data) async {
    print('${data.password} - Senha');
    var response = _errorHandler(await put('cliente/senha', jsonEncode(data)));
  }

  Future<void> putResetPassword(PasswordModel data) async {
    print('${data.password} - Senha');
    var response = _errorHandler(await put('reset-password', jsonEncode(data)));
  }

  Future<List<AddressModel>> getUserAddresses() async {
    var response = _errorHandler(await get('enderecos'));

    List<AddressModel> data = [];

    for (var address in response.body) {
      data.add(AddressModel.fromJson(address));
    }
    return data;
  }

  Future<void> postAddress(UserAddressRequestModel data) async {
    _errorHandler(await post('endereco', jsonEncode(data)));
  }

  Future<void> putAddress(UserAddressRequestModel data) async {
    _errorHandler(await put('endereco/${data.id}', jsonEncode(data)));
  }

  Future<void> deleteAddress(int id) async {
    _errorHandler(await delete('enderecos/$id'));
  }

  Future<DonationAquariumModel> getDonationAquarium(int id) async {
    var response = _errorHandler(await get('doacao/aquario/$id'));

    print("${response.bodyString} getDonationsAquarium - detalhe");

    return DonationAquariumModel.fromJson(response.body);
  }

  Future<void> putActivateAquarium(int id) async {
    _errorHandler(await put('doacao/ativacao/aquario/$id', jsonEncode));
  }

  Future<void> putAquariumInactivate(int id) async {
    _errorHandler(await put('doacao/inativacao/aquario/$id', jsonEncode));
  }

  Future<void> deleteAquarium(int id) async {
    _errorHandler(await put('doacao/excluir/aquario/$id', jsonEncode));
  }

  Future<void> putActivatePet(int id) async {
    _errorHandler(await put('doacao/ativacao/pet/$id', jsonEncode));
  }

  Future<void> putPetInactivate(int id) async {
    _errorHandler(await put('doacao/inativacao/pet/$id', jsonEncode));
  }

  Future<void> deletePet(int id) async {
    _errorHandler(await put('doacao/excluir/pet/$id', jsonEncode));
  }

  Future<DonationPetModel> getDonationPet(int id) async {
    var response = _errorHandler(await get('doacao/pet/$id'));

    print("${response.bodyString} getDonationsAquarium - detalhe");

    return DonationPetModel.fromJson(response.body);
  }

  Future<SpecieModel> getSpecie(SpecieRequestModel data) async {
    print("${data.name} - iD ESPECIE");

    var response =
        _errorHandler(await post('especie/especieId', jsonEncode(data)));

    return SpecieModel.fromJson(response.body);
  }

  Future<ForgotPasswordResponseModel> getVerificationCode(int codigo) async {
    var response = _errorHandler(await get('verificacao-codigo/$codigo'));

    return ForgotPasswordResponseModel.fromJson(response.body);
  }

  Future<List<DonationAquariumModel>> getDonationsAquarium() async {
    var response = _errorHandler(await get('doacoes-aquario'));
    print("getDonationsAquarium - inicio");
    List<DonationAquariumModel> data = [];

    for (var donation in response.body) {
      data.add(DonationAquariumModel.fromJson(donation));
    }
    print("getDonationsAquarium - final");

    return data;
  }

  Future<List<DonationAquariumModel>> getMyDonationsAquarium() async {
    var response = _errorHandler(await get('doacao/lista-aquario'));

    List<DonationAquariumModel> data = [];

    for (var donation in response.body) {
      data.add(DonationAquariumModel.fromJson(donation));
    }

    return data;
  }

  Future<List<DonationPetModel>> getDonationsPet(int id) async {
    var response = _errorHandler(await get('doacoes-pet/$id'));

    List<DonationPetModel> data = [];

    for (var donation in response.body) {
      data.add(DonationPetModel.fromJson(donation));
    }
    return data;
  }

  Future<List<DonationPetModel>> getMyDonationsPet() async {
    var response = _errorHandler(await get('doacao/lista-pet'));

    List<DonationPetModel> data = [];

    for (var donation in response.body) {
      data.add(DonationPetModel.fromJson(donation));
    }
    return data;
  }

  Future<ClientModel> getClient(int id) async {
    var response = _errorHandler(await get('cliente/$id'));

    return ClientModel.fromJson(response.body);
  }

  Response _errorHandler(Response response) {
    //print("${response.bodyString} asasass");
    switch (response.statusCode) {
      case 200:
      case 202:
      case 204:
        return response;
      case 422:
        throw response.body['errors'].first['message'];
      default:
        throw response.body['errors'].first['message'];
    }
  }
}
