import 'dart:async';

import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';

class AboutWidget extends StatefulWidget {
  const AboutWidget({Key key, this.animationController, this.animation})
      : super(key: key);

  final AnimationController animationController;
  final Animation animation;

  @override
  _AboutWidgetState createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            leading: SvgPicture.asset(
                'assets/eva_icons/outline/svg/shield-outline.svg'),
            title: const Text(
              'Privacy Policy',
              style: TextStyle(fontFamily: AppTheme.fontName),
            ),
            horizontalTitleGap: 2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            trailing: SvgPicture.asset(
                'assets/eva_icons/outline/svg/arrow-ios-forward-outline.svg'),
            onTap: () {},
          ),
          const Divider(
            height: 1,
            thickness: 1.0,
            indent: 60,
          ),
          ListTile(
            leading: SvgPicture.asset(
                'assets/eva_icons/outline/svg/file-text-outline.svg'),
            title: const Text(
              'Terms and Conditions',
              style: TextStyle(fontFamily: AppTheme.fontName),
            ),
            horizontalTitleGap: 2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            trailing: SvgPicture.asset(
                'assets/eva_icons/outline/svg/arrow-ios-forward-outline.svg'),
            onTap: () {},
          ),
          const Divider(
            height: 1,
            thickness: 1.0,
            indent: 60,
          ),
          ListTile(
            leading: SvgPicture.asset(
                'assets/eva_icons/outline/svg/star-outline.svg'),
            title: Text(
              _packageInfo.appName,
              style: const TextStyle(fontFamily: AppTheme.fontName),
            ),
            horizontalTitleGap: 2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            trailing: Text(
              _packageInfo.version,
              style: const TextStyle(fontFamily: AppTheme.fontName),
            ),
            onTap: () {},
          ),
          const Divider(
            height: 1,
            thickness: 1.0,
            indent: 60,
          ),
        ],
      ),
    );
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
}
