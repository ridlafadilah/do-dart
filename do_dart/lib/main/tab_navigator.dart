import 'package:do_dart/main/exercise/exercise_page.dart';
import 'package:do_dart/main/home/home_page.dart';
import 'package:do_dart/main/profile/profile_page.dart';
import 'package:do_dart/main/ui_template/ui_template_page.dart';
import 'package:flutter/material.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String home = '/home';
  static const String exercise = '/exercise';
  static const String uitemplate = '/uitemplate';
  static const String profile = '/profile';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tab, this.animationController});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tab;
  final AnimationController animationController;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.root: (context) =>
          HomePage(animationController: animationController),
      TabNavigatorRoutes.home: (context) =>
          HomePage(animationController: animationController),
      TabNavigatorRoutes.exercise: (context) =>
          ExercisePage(animationController: animationController),
      TabNavigatorRoutes.uitemplate: (context) =>
          UITemplatePage(animationController: animationController),
      TabNavigatorRoutes.profile: (context) =>
          ProfilePage(animationController: animationController),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: tab,
      onGenerateRoute: (routeSettings) {
        if (tab == routeSettings.name) {
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                routeBuilders[routeSettings.name](context),
          );
        }
        return null;
      },
    );
  }
}