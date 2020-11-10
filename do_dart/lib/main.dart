import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dongkap_app.dart';
import 'environments/environment.dart';
import 'configs/security_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupConfiguration(Environment(), SecurityConfig());
  await setupLocator();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(DongkapApp()));
}
