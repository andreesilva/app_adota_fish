import 'dart:convert';
import 'dart:io';
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
  dynamic _url = 'http://3.133.141.235:3333';
  bool isInternet = false;

  //final token = _storageService.token;

  /*
  final _baseHeader = {
    HttpHeaders.authorizationHeader: token(),
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
  };
  */

  @override
  void onInit() {
    //LOCAL
    //httpClient.baseUrl = "http://10.0.0.230:3333/";
    //_url = httpClient.baseUrl = "http://10.0.0.230:3333";
    //httpClient.baseUrl = "http://192.168.192.19:3333/";

    //Produção
    httpClient.baseUrl = "http://3.133.141.235:3333/";
    //_url = httpClient.baseUrl = "http://3.133.141.235:3333";

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
    /*
    var response = _errorHandler(await get('cidades'));

    List<CityModel> data = [];

    for (var city in response.body) {
      data.add(CityModel.from(city));
    }

    return data;
    */

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
    /*
    var response = _errorHandler(await get('cidades/$id'));

    List<CityFullModel> data = [];

    for (var city in response.body) {
      data.add(CityFullModel.from(city));
    }
    return data;
    */

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
    /*
    var response = _errorHandler(await get('especie/$id'));

    List<SpecieModel> data = [];

    for (var city in response.body) {
      data.add(SpecieModel.fromJson(city));
    }
    return data;
    */

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
    /*
    var response = _errorHandler(await get('estados'));

    List<StateModel> data = [];

    for (var state in response.body) {
      data.add(StateModel.from(state));
    }
    return data;
    */

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
    /*
    var response = _errorHandler(await post('login', jsonEncode(data)));

    return UserLoginResponseModel.fromJson(response.body);
    */

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
    /*
    var response =
        _errorHandler(await post('forgot-password', jsonEncode(data)));


    return ForgotPasswordResponseModel.fromJson(response.body);
*/
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
    /*
    var response =
        _errorHandler(await post('cliente/cadastro', jsonEncode(data)));

    return UserModel.fromJson(response.body);
    */

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
    /*
    var response =
        _errorHandler(await post('doacao/cadastro-aquario', jsonEncode(data)));

    return AquariumModel.fromJson(response.body);
    */

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
    /*
    var response =
        _errorHandler(await post('doacao/cadastro-pet', jsonEncode(data)));

    return PetModel.fromJson(response.body);
    */
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
    _errorHandler(await put('cliente/foto', jsonEncode(data)));

    try {
      await _client.put(
        Uri.parse('$_url/cliente/foto'),
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

  Future<UserModel> getUser() async {
    /*
    var response = _errorHandler(await get('auth/me'));

    return UserModel.fromJson(response.body);
    */

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
    /*
    var response = _errorHandler(await put('cliente/editar', jsonEncode(data)));

    return UserModel.fromJson(response.body);
    */

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
    //print('${data.password} - Senha');
    //var response = _errorHandler(await put('cliente/senha', jsonEncode(data)));

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
    //print('${data.password} - Senha');
    //var response = _errorHandler(await put('reset-password', jsonEncode(data)));

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
    /*
    var response = _errorHandler(await get('enderecos'));

    List<AddressModel> data = [];

    for (var address in response.body) {
      data.add(AddressModel.fromJson(address));
    }
    return data;
    */

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
    //_errorHandler(await post('endereco', jsonEncode(data)));

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
    //_errorHandler(await put('endereco/${data.id}', jsonEncode(data)));

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

  Future<void> deleteAddress(int id) async {
    _errorHandler(await delete('enderecos/$id'));
  }

  Future<DonationAquariumModel> getDonationAquarium(int id) async {
    /*
    var response = _errorHandler(await get('doacao/aquario/$id'));

    return DonationAquariumModel.fromJson(response.body);
    */
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
    //_errorHandler(await put('doacao/ativacao/aquario/$id', jsonEncode));

    try {
      await _client.put(
        Uri.parse('$_url/doacao/ativacao/aquario/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${_storageService.token}',
        },
        //body: jsonEncode(id),
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> putAquariumInactivate(int id) async {
    //_errorHandler(await put('doacao/inativacao/aquario/$id', jsonEncode));

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
    //_errorHandler(await put('doacao/excluir/aquario/$id', jsonEncode));

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
    //_errorHandler(await put('doacao/ativacao/pet/$id', jsonEncode));

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
    //_errorHandler(await put('doacao/inativacao/pet/$id', jsonEncode));

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
    //_errorHandler(await put('doacao/excluir/pet/$id', jsonEncode));

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
    /*
    var response = _errorHandler(await get('doacao/pet/$id'));

    return DonationPetModel.fromJson(response.body);
    */
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
/*
    print(response.statusCode);
    if (response.statusCode == 200) {
      return DonationPetModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(Exception().toString());
    }
    */
  }

  Future<SpecieModel> getSpecie(SpecieRequestModel data) async {
    //print("${data.name} - iD ESPECIE");
    /*
    var response =
        _errorHandler(await post('especie/especieId', jsonEncode(data)));

    return SpecieModel.fromJson(response.body);
    */
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
    /*
    var response = _errorHandler(await get('verificacao-codigo/$codigo'));

    return ForgotPasswordResponseModel.fromJson(response.body);
  */

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
    /*
    var response = _errorHandler(await get('doacoes-aquario/$id'));
  
    List<DonationAquariumModel> data = [];

    for (var donation in response.body) {
      data.add(DonationAquariumModel.fromJson(donation));
    }

    return data;
    */

    List<DonationAquariumModel> data = [];

    var response = await _client.get(
      Uri.parse('$_url/doacoes-aquario/$id'),
    );

    for (var donation in jsonDecode(response.body)) {
      data.add(DonationAquariumModel.fromJson(donation));
    }
    return data;
  }

  Future<List<DonationPetModel>> getDonationsPet(int id) async {
    /*
     try{
    var response = await get('doacoes-pet/$id');

    List<DonationPetModel> data = [];

    for (var donation in jsonDecode(response.body)) {
      data.add(DonationPetModel.fromJson(donation));
    }
  
    return data;

    }catch(e){
      
       rethrow;
    }
    */

    //try{

/*
    List<DonationPetModel> data = [];

    var response = await _client.get(
      Uri.parse('$_url/doacoes-pet/$id'),
    );

    for (var donation in jsonDecode(response.body)) {
      data.add(DonationPetModel.fromJson(donation));
    }
    return data;
    */

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
    /*
    var response = _errorHandler(await get('doacao/lista-aquario'));

    List<DonationAquariumModel> data = [];

    for (var donation in response.body) {
      data.add(DonationAquariumModel.fromJson(donation));
    }

    return data;
    */

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
    /*
    var response = _errorHandler(await get('doacao/lista-pet'));

    List<DonationPetModel> data = [];

    for (var donation in response.body) {
      data.add(DonationPetModel.fromJson(donation));
    }
    return data;
    */

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
    /*
    var response = _errorHandler(await get('cliente/$id'));

    return ClientModel.fromJson(response.body);

    */
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

  Response _errorHandler(Response response) {
    //print("${response.bodyString} asasass");
    switch (response.statusCode) {
      case 200:
      case 202:
      case 204:
        return response;
      case 422:
        throw response.body['errors'];
      default:
        throw response.body['errors'];
    }
  }
}
