import 'package:do_core/core.dart';
import 'package:do_dart/main/about/about_page.dart';
import 'package:do_dart/main/security/security_page.dart';
import 'package:do_dart/main/settings/settings_page.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileBottomMenu extends StatelessWidget {
  const ProfileBottomMenu({Key key, this.animationController})
      : super(key: key);

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      color: Colors.transparent,
      child: Card(
        color: Colors.white,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        borderOnForeground: true,
        elevation: 0,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: SvgPicture.asset(
                  'assets/eva_icons/outline/svg/settings-outline.svg'),
              title: const Text(
                'Settings',
                style: TextStyle(fontFamily: AppTheme.fontName),
              ),
              horizontalTitleGap: 2,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => SettingsPage(
                          animationController: animationController)),
                );
              },
            ),
            const Divider(
              height: 1,
              thickness: 1.0,
              indent: 65,
              endIndent: 10,
            ),
            ListTile(
              leading: SvgPicture.asset(
                  'assets/eva_icons/outline/svg/lock-outline.svg'),
              title: const Text(
                'Security',
                style: TextStyle(fontFamily: AppTheme.fontName),
              ),
              horizontalTitleGap: 2,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => SecurityPage(
                          animationController: animationController)),
                );
              },
            ),
            const Divider(
              height: 1,
              thickness: 1.0,
              indent: 65,
              endIndent: 10,
            ),
            ListTile(
              leading: SvgPicture.asset(
                  'assets/eva_icons/outline/svg/info-outline.svg'),
              title: const Text(
                'About',
                style: TextStyle(fontFamily: AppTheme.fontName),
              ),
              horizontalTitleGap: 2,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          AboutPage(animationController: animationController)),
                );
              },
            ),
            const Divider(
              height: 1,
              thickness: 1.0,
              indent: 65,
              endIndent: 10,
            ),
            ListTile(
              leading: SvgPicture.asset(
                  'assets/eva_icons/outline/svg/power-outline.svg'),
              title: const Text(
                'Logout',
                style: TextStyle(fontFamily: AppTheme.fontName),
              ),
              horizontalTitleGap: 2,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              onTap: () async {
                AuthService authService =
                    RepositoryProvider.of<AuthService>(context);
                await authService.logOut();
              },
            ),
            const Divider(
              height: 1,
              thickness: 1.0,
              indent: 65,
              endIndent: 10,
            ),
          ],
        ),
      ),
    );
  }
}
