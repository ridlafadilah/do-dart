import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dongkap_app.dart';
import 'environments/environment_prod.dart';
import 'configs/security_config.dart';
import 'configs/api_config.dart';

void main() async {
  setupConfiguration(EnviromentProduction(), SecurityConfig(), APIConfig());
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(DongkapApp()));
}
