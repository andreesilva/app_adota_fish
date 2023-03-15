import 'package:app_adota_fish/app/data/models/city_full.dart';
import 'package:app_adota_fish/app/data/models/forgot_password_request.dart';
import 'package:app_adota_fish/app/data/models/forgot_password_response.dart';
import 'package:app_adota_fish/app/data/models/user.dart';
import 'package:app_adota_fish/app/data/models/user_profile_request.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class VerificationCodeRepository {
  final Api _api;

  VerificationCodeRepository(this._api);

  Future<ForgotPasswordResponseModel> getVerificationCode(int codigo) =>
      _api.getVerificationCode(codigo);
}
