import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key key, this.animationController, this.animation})
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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 16, bottom: 18),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppTheme.grey.withOpacity(0.4),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 130,
                                        right: 16,
                                        top: 16,
                                      ),
                                      child: Text(
                                        'Ridla Fadilah',
                                        softWrap: false,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: -0.2,
                                            color: AppTheme.darkText),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 130,
                                        bottom: 25,
                                        top: 4,
                                        right: 16,
                                      ),
                                      child: Text(
                                        'ridla.fadilah@gmail.com',
                                        softWrap: false,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          letterSpacing: 0.0,
                                          color: AppTheme.grey.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -20,
                        left: 15,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppTheme.grey.withOpacity(0.1),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 5.0),
                            ],
                          ),
                          padding: const EdgeInsets.only(left: 5),
                          child: Stack(
                            children: <Widget>[
                              const CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage('assets/avatars/default.png'),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: AppTheme.nearlyWhite,
                                    shape: BoxShape.circle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: AppTheme.grey.withOpacity(0.1),
                                          offset: const Offset(1.0, 1.0),
                                          blurRadius: 5.0),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        highlightColor: Colors.transparent,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4.0)),
                                        onTap: () {
                                          print('a');
                                        },
                                        child: SvgPicture.asset(
                                            'assets/eva_icons/fill/svg/camera.svg',
                                            color: AppTheme.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
