import 'dart:io';
import 'package:do_dart/environments/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:do_dart/app_theme.dart';
import 'package:do_dart/auth/auth.dart';
import 'package:do_dart/main/main_app_home_screen.dart';
import 'package:global_configuration/global_configuration.dart';

import 'configs/security_config.dart';

class DongkapApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    MainAppHomeScreen.tag: (context) => MainAppHomeScreen(),
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Dongkap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}

setupConfiguration(Enviroment env) {
  GlobalConfiguration().loadFromMap(env.host);
  GlobalConfiguration().addValue('profile', env.profile);
  GlobalConfiguration().addValue('locale', env.locale);
}

setupLocator() {
  setupAuthLocator();
  authLocator.allowReassignment = true;
  authLocator.registerSingleton<SecuritySettings>(SecurityConfig());
}
