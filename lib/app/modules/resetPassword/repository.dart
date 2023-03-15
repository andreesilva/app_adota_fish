import 'package:app_adota_fish/app/data/models/password.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';

class ResetPasswordRepository {
  final Api _api;

  ResetPasswordRepository(this._api);

  Future<void> putPassword(PasswordModel password) =>
      _api.putResetPassword(password);
}
