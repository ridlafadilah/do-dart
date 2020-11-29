import 'package:do_dart/main/exercise/exercise_page.dart';
import 'package:do_dart/main/home/home_page.dart';
import 'package:do_dart/main/profile/profile_page.dart';
import 'package:do_dart/main/ui_template/ui_template_page.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MainLayout());
  }

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/eva_icons/outline/svg/home-outline.svg',
      selectedImagePath: 'assets/eva_icons/fill/svg/home.svg',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/eva_icons/outline/svg/layout-outline.svg',
      selectedImagePath: 'assets/eva_icons/fill/svg/layout.svg',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/eva_icons/outline/svg/bulb-outline.svg',
      selectedImagePath: 'assets/eva_icons/fill/svg/bulb.svg',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/eva_icons/outline/svg/person-outline.svg',
      selectedImagePath: 'assets/eva_icons/fill/svg/person.svg',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.exercise: GlobalKey<NavigatorState>(),
    TabItem.template: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    tabBody = HomePage(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                ],
              );
            }
          },
        ),
        bottomNavigationBar: bottomNavigation(),
        extendBody: true,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomNavigation() {
    return BottomBarNavigation(
      tabIconsList: tabIconsList,
      addClick: () {},
      changeIndex: (int index) {
        switch (index) {
          case 0:
            animationController.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody = HomePage(animationController: animationController);
              });
            });
            break;
          case 1:
            animationController.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody =
                    ExercisePage(animationController: animationController);
              });
            });
            break;
          case 2:
            animationController.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody =
                    UITemplatePage(animationController: animationController);
              });
            });
            break;
          case 3:
            animationController.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody = ProfilePage(animationController: animationController);
              });
            });
            break;
          default:
        }
      },
    );
  }
}

enum TabItem { home, exercise, template, profile }
