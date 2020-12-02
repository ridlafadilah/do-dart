import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({Key key, this.animationController, this.animation})
      : super(key: key);

  final AnimationController animationController;
  final Animation animation;

  @override
  _LanguageWidgetState createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
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
            title: const Text(
              'English',
              style: TextStyle(fontFamily: AppTheme.fontName),
            ),
            subtitle: const Text(
              'United States',
              style: TextStyle(fontFamily: AppTheme.fontName),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            trailing: SvgPicture.asset(
                'assets/eva_icons/outline/svg/checkmark-outline.svg'),
            onTap: () {},
          ),
          const Divider(
            height: 1,
            thickness: 1.0,
            indent: 20,
          ),
          ListTile(
            title: const Text(
              'Indonesian',
              style: TextStyle(fontFamily: AppTheme.fontName),
            ),
            subtitle: const Text(
              'Indonesia',
              style: TextStyle(fontFamily: AppTheme.fontName),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            onTap: () {},
          ),
          const Divider(
            height: 1,
            thickness: 1.0,
            indent: 20,
          ),
        ],
      ),
    );
  }
}
