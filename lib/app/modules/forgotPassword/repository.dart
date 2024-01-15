import 'package:app_adota_fish/app/data/models/city_full.dart';
import 'package:app_adota_fish/app/data/models/forgot_password_request.dart';
import 'package:app_adota_fish/app/data/models/forgot_password_response.dart';
import 'package:app_adota_fish/app/data/models/user.dart';
import 'package:app_adota_fish/app/data/models/user_profile_request.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class ForgotPasswordRepository {
  final Api _api;

  ForgotPasswordRepository(this._api);

  Future<UserModel> register(UserProfileRequestModel userProfileRequest) =>
      _api.register(userProfileRequest);

  Future<ForgotPasswordResponseModel> forgotPassword(
          ForgotPasswordRequestModel forgotPasswordRequestModel) =>
      _api.forgotPassword(forgotPasswordRequestModel);
}
