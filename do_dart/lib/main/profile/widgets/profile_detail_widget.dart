import 'package:do_core/models.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileDetailWidget extends StatelessWidget {
  const ProfileDetailWidget(
      {Key key, this.animationController, this.animation, this.profile})
      : super(key: key);

  final AnimationController animationController;
  final Animation animation;
  final ProfileDto profile;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        String pdb = '';
        if (profile != null) {
          profile.placeOfBirth =
              profile.placeOfBirth != null ? profile.placeOfBirth : '';
          profile.dateOfBirth =
              profile.dateOfBirth != null ? profile.dateOfBirth : '';
          pdb = '${profile.placeOfBirth}, ${profile.dateOfBirth}';
        }
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.lightColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.darkGrey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 4, right: 24, top: 5, bottom: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            leading: SvgPicture.asset(
                                'assets/eva_icons/outline/svg/person-outline.svg',
                                color: AppTheme.darkGrey),
                            title: Text(
                              DongkapLocalizations.of(context).username,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: AppTheme.darkText,
                              ),
                            ),
                            subtitle: Text(
                              profile.username,
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppTheme.darkGrey.withOpacity(0.5),
                              ),
                            ),
                            horizontalTitleGap: 5,
                            onTap: () {},
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                                'assets/eva_icons/outline/svg/phone-outline.svg',
                                color: AppTheme.darkGrey),
                            title: Text(
                              DongkapLocalizations.of(context).phoneNumber,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: AppTheme.darkText,
                              ),
                            ),
                            subtitle: Text(
                              profile.phoneNumber != null
                                  ? profile.phoneNumber
                                  : '',
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppTheme.darkGrey.withOpacity(0.5),
                              ),
                            ),
                            horizontalTitleGap: 5,
                            onTap: () {},
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                                'assets/eva_icons/outline/svg/people-outline.svg',
                                color: AppTheme.darkGrey),
                            title: Text(
                              DongkapLocalizations.of(context).gender,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: AppTheme.darkText,
                              ),
                            ),
                            subtitle: Text(
                              profile.gender != null ? profile.gender : '',
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppTheme.darkGrey.withOpacity(0.5),
                              ),
                            ),
                            horizontalTitleGap: 5,
                            onTap: () {},
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                                'assets/eva_icons/outline/svg/calendar-outline.svg',
                                color: AppTheme.darkGrey),
                            title: Text(
                              DongkapLocalizations.of(context).pdob,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: AppTheme.darkText,
                              ),
                            ),
                            subtitle: Text(
                              pdb,
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppTheme.darkGrey.withOpacity(0.5),
                              ),
                            ),
                            horizontalTitleGap: 5,
                            onTap: () {},
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                                'assets/eva_icons/outline/svg/home-outline.svg',
                                color: AppTheme.darkGrey),
                            title: Text(
                              DongkapLocalizations.of(context).address,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: AppTheme.darkText,
                              ),
                            ),
                            subtitle: Text(
                              profile.address != null ? profile.address : '',
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppTheme.darkGrey.withOpacity(0.5),
                              ),
                            ),
                            horizontalTitleGap: 5,
                            onTap: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
