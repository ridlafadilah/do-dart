import 'dart:async';

import 'package:flutter/material.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';

class AboutWidget extends StatefulWidget {
  const AboutWidget({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;

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
    _initPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            leading: SvgPicture.asset(
              'assets/eva_icons/outline/svg/shield-outline.svg',
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              DongkapLocalizations.of(context).privacyPolicy,
            ),
            horizontalTitleGap: 2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            trailing: SvgPicture.asset(
              'assets/eva_icons/outline/svg/arrow-ios-forward-outline.svg',
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {},
          ),
          const Divider(
            height: 1,
            indent: 60,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/eva_icons/outline/svg/file-text-outline.svg',
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              DongkapLocalizations.of(context).termsAndConditions,
            ),
            horizontalTitleGap: 2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            trailing: SvgPicture.asset(
              'assets/eva_icons/outline/svg/arrow-ios-forward-outline.svg',
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {},
          ),
          const Divider(
            height: 1,
            indent: 60,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/eva_icons/outline/svg/star-outline.svg',
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              _packageInfo.appName,
            ),
            horizontalTitleGap: 2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            trailing: Text(
              _packageInfo.version,
            ),
            onTap: () {},
          ),
          const Divider(
            height: 1,
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
