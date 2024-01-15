import 'package:app_adota_fish/app/data/models/forgot_password_request.dart';
import 'package:app_adota_fish/app/data/models/forgot_password_response.dart';
import 'package:app_adota_fish/app/data/models/user.dart';
import 'package:app_adota_fish/app/data/models/user_login_request.dart';
import 'package:app_adota_fish/app/data/models/user_login_response.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class AuthRepository {
  final Api _api;

  AuthRepository(this._api);

  Future<UserLoginResponseModel> login(
          UserLoginRequestModel userLoginRequestModel) =>
      _api.login(userLoginRequestModel);
  Future<UserModel> getUser() => _api.getUser();
  // Future <ForgotPasswordResponseModel>forgotPassword(ForgotPasswordRequestModel forgotPasswordRequestModel) => _api.forgotPassword(userLoginRequestModel);
  Future<ForgotPasswordResponseModel> forgotPassword(
          ForgotPasswordRequestModel forgotPasswordRequestModel) =>
      _api.forgotPassword(forgotPasswordRequestModel);
}
