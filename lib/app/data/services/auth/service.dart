import 'dart:io';

import 'package:app_adota_fish/app/data/models/user.dart';
import 'package:app_adota_fish/app/data/models/user_login_request.dart';
import 'package:app_adota_fish/app/data/services/auth/repository.dart';
import 'package:app_adota_fish/app/data/services/storage/service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetxService {
  final _storageService = Get.find<StorageService>();
  AuthRepository _repository;
  final user = Rxn<UserModel>();
  bool get isLogged => user.value != null;
  AuthService(this._repository);
  //bool isInternet = false;
  
  /*
  Future<bool> _isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      
        isInternet = true;
      //return res;
    } on SocketException catch (_) {

        isInternet = false;
    }
     return isInternet;
  }
  */

  //Future get isInternet_ =>  _isInternetConnected();


  /*
  isInternet_  =  _isInternetConnected().then((value) {});

  isInternetConnected().then((value) {
      
     
      if(value == false){
        Get.toNamed(Routes.splash);
      }
      */

  @override
  void onInit() async {
    if (_storageService.token != null) {
      await _getUser();
    }

     //isInternetConnected().then((value) => value);

    super.onInit();
  }

  

  Future<void> login(UserLoginRequestModel userLoginRequestModel) async {
    var userLoginResponse = await _repository.login(userLoginRequestModel);
    await _storageService.saveToken(userLoginResponse.token);
    await _getUser();

    print(userLoginResponse.token);
  }

  Future<void> logout() async {
    await _storageService.removeToken();
    user.value = null;
  }

  Future _getUser() {
    return _repository.getUser().then((value) {
      user.value = value;
    });
  }
}
