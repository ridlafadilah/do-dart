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

class TabNavigator extends StatefulWidget {
  TabNavigator({this.navigatorKey, this.tab, this.animationController});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tab;
  final AnimationController animationController;

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.root: (context) =>
          HomePage(animationController: widget.animationController),
      TabNavigatorRoutes.home: (context) =>
          HomePage(animationController: widget.animationController),
      TabNavigatorRoutes.exercise: (context) =>
          ExercisePage(animationController: widget.animationController),
      TabNavigatorRoutes.uitemplate: (context) =>
          UITemplatePage(animationController: widget.animationController),
      TabNavigatorRoutes.profile: (context) => ProfilePage(
          animationController: widget.animationController,
          navigatorState: getNavigatorState()),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: widget.tab,
      onGenerateRoute: (routeSettings) {
        if (widget.tab == routeSettings.name) {
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                routeBuilders[routeSettings.name](context),
          );
        }
        return null;
      },
    );
  }

  NavigatorState getNavigatorState() {
    return Navigator.of(context);
  }
}
