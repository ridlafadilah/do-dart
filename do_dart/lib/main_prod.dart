import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dongkap_app.dart';
import 'environments/environment_prod.dart';

void main() async {
  setupConfiguration(EnviromentProduction());
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(DongkapApp()));
}
