import 'package:do_dart/main/settings/language_page.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key key, this.animationController, this.animation})
      : super(key: key);

  final AnimationController animationController;
  final Animation animation;

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  bool isDarkMode = false;
  String iconDarkMode = 'assets/eva_icons/fill/svg/moon.svg';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            leading: SvgPicture.asset(
                'assets/eva_icons/outline/svg/globe-outline.svg'),
            title: const Text(
              'Language',
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
                    builder: (BuildContext context) => LanguagePage(
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
                child: SvgPicture.asset(iconDarkMode)),
            title: const Text(
              'Dark Mode',
              style: TextStyle(fontFamily: AppTheme.fontName),
            ),
            contentPadding: const EdgeInsets.only(left: 5.0, right: 15.0),
            value: isDarkMode,
            activeColor: AppTheme.colorTheme,
            onChanged: (bool value) {
              setState(() {
                isDarkMode = value;
                iconDarkMode = value
                    ? 'assets/eva_icons/outline/svg/moon-outline.svg'
                    : 'assets/eva_icons/fill/svg/moon.svg';
              });
            },
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
