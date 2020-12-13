import 'dart:io';
import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_dart/auth/auth.dart';
import 'package:do_dart/auth/page/login/bloc/authentication/authentication_bloc.dart';
import 'package:do_dart/configs/security_config.dart';
import 'package:do_dart/environments/environment.dart';
import 'package:do_dart/l10n/bloc/translation_bloc.dart';
import 'package:do_dart/main/main_layout.dart';
import 'package:do_dart/splash/splash.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';

class DongkapApp extends StatelessWidget {
  const DongkapApp({Key key}) : super(key: key);

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

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(
              authService: RepositoryProvider.of<AuthService>(_)),
        ),
        BlocProvider<TranslationBloc>(
          create: (_) => TranslationBloc()..add(const TranslationEvent()),
        )
      ], child: DongkapAppView()),
    );
  }
}

class DongkapAppView extends StatefulWidget {
  @override
  _DongkapAppViewState createState() => _DongkapAppViewState();
}

class _DongkapAppViewState extends State<DongkapAppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  static const List<Locale> supportedLocales = <Locale>[
    Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    Locale.fromSubtags(languageCode: 'id', countryCode: 'ID'),
  ];
  Locale localeDefault =
      const Locale.fromSubtags(languageCode: 'en', countryCode: 'US');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationBloc, TranslationState>(
      builder: (BuildContext context, TranslationState state) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          title: 'Dongkap',
          debugShowCheckedModeBanner:
              GlobalConfiguration().getValue<bool>('debug'),
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: AppTheme.textTheme,
            platform: TargetPlatform.iOS,
          ),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: supportedLocales,
          locale: state.locale,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      MainLayout.route(),
                      (route) => false,
                    );
                    break;
                  case AuthStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                      (route) => false,
                    );
                    break;
                  default:
                    break;
                }
              },
              child: child,
            );
          },
          onGenerateRoute: (_) => SplashPage.route(),
        );
      },
    );
  }
}

void setupConfiguration(Environment env, SecurityConfig sec) {
  GlobalConfiguration()
      .loadFromMap(env.config)
      .loadFromMap(env.hosts)
      .loadFromMap(sec.config);
}

Future<void> setupLocator() async {
  await setupCoreLocator();
}
