import 'package:app_adota_fish/app/modules/account/binding.dart';
import 'package:app_adota_fish/app/modules/account/page.dart';
import 'package:app_adota_fish/app/modules/myDonationsAquarium/binding.dart';
import 'package:app_adota_fish/app/modules/myDonationsAquarium/page.dart';
import 'package:app_adota_fish/app/modules/dashboard/binding.dart';
import 'package:app_adota_fish/app/modules/dashboard/page_pet.dart';
import 'package:app_adota_fish/app/modules/dashboard/page_aquarium.dart';
import 'package:app_adota_fish/app/modules/donationAquarium/binding.dart';
import 'package:app_adota_fish/app/modules/donationAquarium/page.dart';
import 'package:app_adota_fish/app/modules/donationPet/binding.dart';
import 'package:app_adota_fish/app/modules/donationPet/page.dart';
import 'package:app_adota_fish/app/modules/login/binding.dart';
import 'package:app_adota_fish/app/modules/login/page.dart';
import 'package:app_adota_fish/app/modules/myDonationsPet/binding.dart';
import 'package:app_adota_fish/app/modules/myDonationsPet/page.dart';
import 'package:app_adota_fish/app/modules/password/binding.dart';
import 'package:app_adota_fish/app/modules/password/page.dart';
import 'package:app_adota_fish/app/modules/photo_client/binding.dart';
import 'package:app_adota_fish/app/modules/photo_client/page.dart';
import 'package:app_adota_fish/app/modules/register/binding.dart';
import 'package:app_adota_fish/app/modules/register/page.dart';
import 'package:app_adota_fish/app/modules/register_aquarium/binding.dart';
import 'package:app_adota_fish/app/modules/register_aquarium/page.dart';
import 'package:app_adota_fish/app/modules/register_pet/binding.dart';
import 'package:app_adota_fish/app/modules/register_pet/page.dart';
import 'package:app_adota_fish/app/modules/forgotPassword/binding.dart';
import 'package:app_adota_fish/app/modules/forgotPassword/page.dart';
import 'package:app_adota_fish/app/modules/resetPassword/binding.dart';
import 'package:app_adota_fish/app/modules/resetPassword/page.dart';
import 'package:app_adota_fish/app/modules/select_state_aquarium/binding.dart';
import 'package:app_adota_fish/app/modules/select_state_aquarium/page.dart';
import 'package:app_adota_fish/app/modules/select_state_pet/binding.dart';
import 'package:app_adota_fish/app/modules/select_state_pet/page.dart';
import 'package:app_adota_fish/app/modules/splash/binding.dart';
import 'package:app_adota_fish/app/modules/splash/page.dart';
import 'package:app_adota_fish/app/modules/user_address/binding.dart';
import 'package:app_adota_fish/app/modules/user_address/page.dart';
import 'package:app_adota_fish/app/modules/user_profile/binding.dart';
import 'package:app_adota_fish/app/modules/user_profile/page.dart';
import 'package:app_adota_fish/app/modules/verificationCode/binding.dart';
import 'package:app_adota_fish/app/modules/verificationCode/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardPetPage(),
      binding: DashboardBinding(),
      //middlewares: [RedirectMiddleware()]
    ),
    GetPage(
      name: Routes.pets,
      page: () =>  const DashboardPetPage(),
      binding: DashboardBinding(),
      //middlewares: [RedirectMiddleware()]
    ),
     GetPage(
      name: Routes.aquariums,
      page: () =>  const DashboardAquariumPage(),
      binding: DashboardBinding(),
      //middlewares: [RedirectMiddleware()]
    ),
    GetPage(
      name: Routes.donationAquarium,
      page: () => DonationAquariumPage(),
      binding: DonationAquariumBinding(),
    ),
    GetPage(
      name: Routes.donationPet,
      page: () => DonationPetPage(),
      binding: DonationPetBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.verificationCode,
      page: () => VerificationCodePage(),
      binding: VerificationCodeBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.registerAquarium,
      page: () => RegisterAquariumPage(),
      binding: RegisterAquariumBinding(),
    ),
    GetPage(
      name: Routes.registerPet,
      page: () => RegistePetPage(),
      binding: RegisterPetBinding(),
    ),
    GetPage(
      name: Routes.photoClient,
      page: () => PhotoClientPage(),
      binding: PhotoClientBinding(),
    ),
    GetPage(
      name: Routes.userAddress,
      page: () => UserAddressPage(),
      binding: UserAddressBinding(),
    ),
    GetPage(
      name: Routes.userProfile,
      page: () => UserProfilePage(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: Routes.userPassword,
      page: () => PasswordPage(),
      binding: PasswordBinding(),
    ),
    GetPage(
      name: Routes.myDonationsAquarium,
      page: () => MyDonationsAquariumPage(),
      binding: MyDonationsAquariumBinding(),
    ),
    GetPage(
      name: Routes.myDonationsPet,
      page: () => MyDonationsPetPage(),
      binding: MyDonationsPetBinding(),
    ),
    GetPage(
      name: Routes.account,
      page: () => AccountPage(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: Routes.resetPassword,
      page: () => ResetPasswordPage(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
        name: Routes.selectStatePet,
        page: () => SelectStatePetPage(),
        binding: SelectStatePetBinding(),
        fullscreenDialog: true),
    GetPage(
        name: Routes.selectStateAquarium,
        page: () => SelectStateAquariumPage(),
        binding: SelectStateAquariumBinding(),
        fullscreenDialog: true),    
  ];
}

class RedirectMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    /*
    if (Get.find<StorageService>().cityId == null) {
      return const RouteSettings(name: Routes.selectCity);
    }
    */

    return null;
  }
}
