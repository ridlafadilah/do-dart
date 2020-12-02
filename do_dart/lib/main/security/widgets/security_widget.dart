import 'package:do_dart/main/security/change_password_page.dart';
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
  bool is2FA = false;
  String is2FAIcon = 'assets/eva_icons/outline/svg/shield-off-outline.svg';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            enabled: false,
            leading: SvgPicture.asset('assets/eva_icons/fill/svg/google.svg'),
            title: const Text(
              'Logged in with Google',
              style:
                  TextStyle(fontFamily: AppTheme.fontName, color: Colors.black),
            ),
            horizontalTitleGap: 2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            onTap: () {},
          ),
          const Divider(
            height: 1,
            thickness: 1.0,
            indent: 60,
          ),
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
            onTap: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => ChangePasswordPage(
                        animationController: widget.animationController)),
              );
            },
          ),
          const Divider(
            height: 1,
            thickness: 1.0,
            indent: 60,
          ),
          SwitchListTile(
            secondary: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: SvgPicture.asset(is2FAIcon)),
            title: const Text(
              '2-Step Verification',
              style: TextStyle(fontFamily: AppTheme.fontName),
            ),
            subtitle: const Text(
              'Send a verification code every time you login',
              style: TextStyle(fontFamily: AppTheme.fontName),
            ),
            contentPadding: const EdgeInsets.only(left: 5.0, right: 15.0),
            value: is2FA,
            activeColor: AppTheme.colorTheme,
            onChanged: (bool value) {
              setState(() {
                is2FA = value;
                is2FAIcon = value
                    ? 'assets/eva_icons/outline/svg/shield-outline.svg'
                    : 'assets/eva_icons/outline/svg/shield-off-outline.svg';
              });
            },
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
