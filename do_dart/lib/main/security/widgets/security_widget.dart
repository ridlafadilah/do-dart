import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecurityWidget extends StatefulWidget {
  const SecurityWidget({Key key, this.animationController, this.animation})
      : super(key: key);

  final AnimationController animationController;
  final Animation animation;

  @override
  _SecurityWidgetState createState() => _SecurityWidgetState();
}

class _SecurityWidgetState extends State<SecurityWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            leading: SvgPicture.asset(
                'assets/eva_icons/outline/svg/lock-outline.svg'),
            title: const Text(
              'Change Password',
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
                'assets/eva_icons/outline/svg/slash-outline.svg'),
            title: const Text(
              'Deactivate Account',
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
        ],
      ),
    );
  }
}
