import 'package:app_adota_fish/app/core/theme/app_theme.dart';
import 'package:app_adota_fish/app/data/providers/api.dart';
import 'package:app_adota_fish/app/data/services/auth/repository.dart';
import 'package:app_adota_fish/app/data/services/auth/service.dart';
import 'package:app_adota_fish/app/data/services/storage/service.dart';
import 'package:app_adota_fish/app/routes/pages.dart';
import 'package:app_adota_fish/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  Get.put<StorageService>(StorageService());
  Get.put<Api>(Api());
  Get.put<AuthService>(AuthService(AuthRepository(Get.find<Api>())));

  Intl.defaultLocale = "pt_BR";

  RendererBinding.instance.setSemanticsEnabled(true);

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.splash,
    theme: themeData,
    getPages: AppPages.pages,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate
    ],
    locale: const Locale('pt', 'BR'),
    supportedLocales: const [Locale("pt", "BR")],
  ));
}
