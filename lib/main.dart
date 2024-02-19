import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tr_store/app/app.dart';
import 'package:tr_store/config/constansts/app_color.dart';
import 'package:tr_store/utils/locator.dart';

void main() {
  initService();
  runApp(const App());
}

Future initService() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarBrightness: Brightness.dark,
    ));
  } else {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: true));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }
  HttpOverrides.global = MyHttpOverrides();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
