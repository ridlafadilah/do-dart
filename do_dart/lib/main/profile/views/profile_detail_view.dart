import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileDetailView extends StatelessWidget {
  const ProfileDetailView({Key key, this.animationController, this.animation})
      : super(key: key);

  final AnimationController animationController;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
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
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.2),
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
                                color: AppTheme.grey),
                            title: const Text(
                              'Username',
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: AppTheme.darkText,
                              ),
                            ),
                            subtitle: Text(
                              'ridlafadilah',
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppTheme.grey.withOpacity(0.5),
                              ),
                            ),
                            horizontalTitleGap: 5,
                            onTap: () {},
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                                'assets/eva_icons/outline/svg/phone-outline.svg',
                                color: AppTheme.grey),
                            title: const Text(
                              'Phone Number',
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: AppTheme.darkText,
                              ),
                            ),
                            subtitle: Text(
                              '+62812345678',
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppTheme.grey.withOpacity(0.5),
                              ),
                            ),
                            horizontalTitleGap: 5,
                            onTap: () {},
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                                'assets/eva_icons/outline/svg/people-outline.svg',
                                color: AppTheme.grey),
                            title: const Text(
                              'Gender',
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: AppTheme.darkText,
                              ),
                            ),
                            subtitle: Text(
                              'Male',
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppTheme.grey.withOpacity(0.5),
                              ),
                            ),
                            horizontalTitleGap: 5,
                            onTap: () {},
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                                'assets/eva_icons/outline/svg/calendar-outline.svg',
                                color: AppTheme.grey),
                            title: const Text(
                              'Place / Date of Birth',
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: AppTheme.darkText,
                              ),
                            ),
                            subtitle: Text(
                              'Tangerang, 01/01/2000',
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppTheme.grey.withOpacity(0.5),
                              ),
                            ),
                            horizontalTitleGap: 5,
                            onTap: () {},
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                                'assets/eva_icons/outline/svg/home-outline.svg',
                                color: AppTheme.grey),
                            title: const Text(
                              'Address',
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: AppTheme.darkText,
                              ),
                            ),
                            subtitle: Text(
                              'Tangerang',
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppTheme.grey.withOpacity(0.5),
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
