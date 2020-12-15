import 'package:do_dart/main/settings/widgets/settings_widget.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: appBar(context),
        body: Stack(
          children: <Widget>[
            mainView(context),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget mainView(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return SettingsWidget(animationController: animationController);
      },
    );
  }

  Widget appBar(BuildContext context) {
    return DongkapAppBar(
      animationController: animationController,
      topBarOpacity: 0.0,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 40,
            width: 40,
            child: InkWell(
              highlightColor: AppTheme.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              onTap: () {
                Navigator.of(context).pop(true);
              },
              child: Center(
                child: SvgPicture.asset(
                    'assets/eva_icons/outline/svg/arrow-back-outline.svg'),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DongkapLocalizations.of(context).settings,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontFamily: AppTheme.fontName,
                fontWeight: FontWeight.w700,
                fontSize: 22 + 6 - 6 * 0.0,
                letterSpacing: 1.2,
                color: AppTheme.darkerText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
