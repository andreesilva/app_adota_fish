import 'dart:convert';
import 'dart:io';
import 'package:app_adota_fish/app/data/models/aquarium_not_photo_request.dart';
import 'package:app_adota_fish/app/data/models/photo_donation_request.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

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
import 'package:app_adota_fish/app/data/models/pet_not_photo_request.dart';
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

  final _client = http.Client();
  dynamic _url = 'https://apiadotafish.a2hosted.com';
  //dynamic _url = 'http://10.0.0.230:3333';
  bool isInternet = false;

  @override
  void onInit() {
    //LOCAL
    //httpClient.baseUrl = "http://10.0.0.230:3333/";
    //_url = httpClient.baseUrl = "http://10.0.0.230:3333";
    //httpClient.baseUrl = "http://192.168.192.19:3333/";

    //Produção
    httpClient.baseUrl = "https://apiadotafish.a2hosted.com/";

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
    List<CityModel> data = [];

    var response = await _client.get(
      Uri.parse('$_url/cidades'),
    );

    for (var city in jsonDecode(response.body)) {
      data.add(CityModel.from(city));
    }
    return data;
  }

  Future<List<CityFullModel>> getCitiesState(int id) async {
    List<CityFullModel> data = [];

    var response = await _client.get(
      Uri.parse('$_url/cidades/$id'),
    );

    for (var city in jsonDecode(response.body)) {
      data.add(CityFullModel.from(city));
    }
    return data;
  }

  Future<List<SpecieModel>> getSpecies(int id) async {
    try {
      List<SpecieModel> data = [];

      var response = await _client.get(
        Uri.parse('$_url/especie/$id'),
        headers: {
          'authorization': 'Bearer ${_storageService.token}',
        },
      );

      for (var donation in jsonDecode(response.body)) {
        data.add(SpecieModel.fromJson(donation));
      }
      print(response.statusCode);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<StateModel>> getStates() async {
    List<StateModel> data = [];

    var response = await _client.get(
      Uri.parse('$_url/estados'),
    );

    for (var state in jsonDecode(response.body)) {
      data.add(StateModel.from(state));
    }
    return data;
  }

  Future<UserLoginResponseModel> login(UserLoginRequestModel data) async {
    try {
      var response = await _client.post(
        Uri.parse('$_url/login'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      return UserLoginResponseModel.fromJson(json.decode(response.body));
    } catch (e) {
      //print(e);
      print(' Erro login de usuário');
      throw e.toString();
    }
  }

  Future<ForgotPasswordResponseModel> forgotPassword(
      ForgotPasswordRequestModel data) async {
    try {
      var response = await _client.post(
        Uri.parse('$_url/forgot-password'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      return ForgotPasswordResponseModel.fromJson(json.decode(response.body));
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<UserModel> register(UserProfileRequestModel data) async {
    try {
      var response = await _client.post(
        Uri.parse('$_url/cliente/cadastro'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      return UserModel.fromJson(json.decode(response.body));
    } catch (e) {
      //print(e);
      throw e.toString();
    }
  }

  Future<AquariumModel> registerAquarium(AquariumRequestModel data) async {
    try {
      var response = await _client.post(
        Uri.parse('$_url/doacao/cadastro-aquario'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
        body: jsonEncode(data),
      );
      return AquariumModel.fromJson(json.decode(response.body));
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<PetModel> registerPet(PetRequestModel data) async {
    try {
      var response = await _client.post(
        Uri.parse('$_url/doacao/cadastro-pet'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
        body: jsonEncode(data),
      );
      return PetModel.fromJson(json.decode(response.body));
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> putPhotoClient(PhotoClientRequestModel data) async {
    try {
      await _client.put(
        Uri.parse('$_url/cliente/foto'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> deleteClient() async {
    try {
      await _client.delete(
        Uri.parse('$_url/cliente/excluir'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> putPhotoPet(PhotoDonationRequestModel data) async {
    try {
      await _client.put(
        Uri.parse('$_url/doacao/pet/foto/${data.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> putPet(PetNotPhotoRequestModel data) async {
    try {
      await _client.put(
        Uri.parse('$_url/doacao/pet/editar/${data.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> putPhotoAquarium(PhotoDonationRequestModel data) async {
    try {
      await _client.put(
        Uri.parse('$_url/doacao/aquario/foto/${data.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> putAquarium(AquariumNotPhotoRequestModel data) async {
    try {
      await _client.put(
        Uri.parse('$_url/doacao/aquario/editar/${data.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<UserModel> getUser() async {
    try {
      final response = await http.get(
        Uri.parse('$_url/auth/me'),
        headers: {
          'authorization': 'Bearer ${_storageService.token}',
        },
      );

      return UserModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel> putUser(UserProfileRequestModel data) async {
    try {
      var response = await _client.put(
        Uri.parse('$_url/cliente/editar'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
        body: jsonEncode(data),
      );

      return UserModel.fromJson(json.decode(response.body));
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> putPassword(PasswordModel data) async {
    try {
      await _client.put(
        Uri.parse('$_url/cliente/senha'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> putResetPassword(PasswordModel data) async {
    try {
      await _client.put(
        Uri.parse('$_url/reset-password'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<List<AddressModel>> getUserAddresses() async {
    try {
      List<AddressModel> data = [];

      var response = await _client.get(
        Uri.parse('$_url/enderecos'),
        headers: {
          'authorization': 'Bearer ${_storageService.token}',
        },
      );

      for (var address in jsonDecode(response.body)) {
        data.add(AddressModel.fromJson(address));
      }
      print(response.statusCode);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> postAddress(UserAddressRequestModel data) async {
    try {
      var response = await _client.post(
        Uri.parse('$_url/endereco'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> putAddress(UserAddressRequestModel data) async {
    try {
      await _client.put(
        Uri.parse('$_url/endereco/${data.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<DonationAquariumModel> getDonationAquarium(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$_url/doacao/aquario/$id'),
        headers: {
          'authorization': 'Bearer ${_storageService.token}',
        },
      );

      return DonationAquariumModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> putActivateAquarium(int id) async {
    try {
      await _client.put(
        Uri.parse('$_url/doacao/ativacao/aquario/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> putAquariumInactivate(int id) async {
    try {
      await _client.put(
        Uri.parse('$_url/doacao/inativacao/aquario/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> deleteAquarium(int id) async {
    try {
      await _client.put(
        Uri.parse('$_url/doacao/excluir/aquario/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> putActivatePet(int id) async {
    try {
      await _client.put(
        Uri.parse('$_url/doacao/ativacao/pet/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> putPetInactivate(int id) async {
    try {
      await _client.put(
        Uri.parse('$_url/doacao/inativacao/pet/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> deletePet(int id) async {
    try {
      await _client.put(
        Uri.parse('$_url/doacao/excluir/pet/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<DonationPetModel> getDonationPet(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$_url/doacao/pet/$id'),
        headers: {
          'authorization': 'Bearer ${_storageService.token}',
        },
      );

      return DonationPetModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<SpecieModel> getSpecie(SpecieRequestModel data) async {
    try {
      var response = await _client.post(
        Uri.parse('$_url/especie/especieId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
        body: jsonEncode(data),
      );
      return SpecieModel.fromJson(json.decode(response.body));
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<ForgotPasswordResponseModel> getVerificationCode(int codigo) async {
    try {
      var response = await http.get(
        Uri.parse('$_url/verificacao-codigo/$codigo'),
      );

      return ForgotPasswordResponseModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<DonationAquariumModel>> getDonationsAquarium(int id) async {
    try {
      List<DonationAquariumModel> data = [];

      var response = await _client.get(
        Uri.parse('$_url/doacoes-aquario/$id'),
      );

      for (var donation in jsonDecode(response.body)) {
        data.add(DonationAquariumModel.fromJson(donation));
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<DonationPetModel>> getDonationsPet(int id) async {
    try {
      List<DonationPetModel> data = [];

      var response = await _client.get(
        Uri.parse('$_url/doacoes-pet/$id'),
      );

      for (var donation in jsonDecode(response.body)) {
        data.add(DonationPetModel.fromJson(donation));
      }
      print(response.statusCode);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<DonationAquariumModel>> getMyDonationsAquarium() async {
    try {
      List<DonationAquariumModel> data = [];

      var response = await _client.get(
        Uri.parse('$_url/doacao/lista-aquario'),
        headers: {
          'authorization': 'Bearer ${_storageService.token}',
        },
      );

      for (var donation in jsonDecode(response.body)) {
        data.add(DonationAquariumModel.fromJson(donation));
      }
      print(response.statusCode);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<DonationPetModel>> getMyDonationsPet() async {
    try {
      List<DonationPetModel> data = [];

      var response = await _client.get(
        Uri.parse('$_url/doacao/lista-pet'),
        headers: {
          'authorization': 'Bearer ${_storageService.token}',
        },
      );

      for (var donation in jsonDecode(response.body)) {
        data.add(DonationPetModel.fromJson(donation));
      }
      print(response.statusCode);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ClientModel> getClient(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$_url/cliente/$id'),
        headers: {
          'authorization': 'Bearer ${_storageService.token}',
        },
      );

      return ClientModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e.toString();
    }
  }
}
