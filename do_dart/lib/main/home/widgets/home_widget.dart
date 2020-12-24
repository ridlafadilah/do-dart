import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key key, this.animationController, this.animation})
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
                  gradient: LinearGradient(
                      colors: [AppTheme.colorTheme, HexColor('#598BFF')],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Theme.of(context)
                            .cardTheme
                            .shadowColor
                            .withOpacity(0.6),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        DongkapLocalizations.of(context).hello,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          letterSpacing: 0.0,
                          color: AppTheme.lightColor,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Ridla Fadilah',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            letterSpacing: 0.0,
                            color: AppTheme.lightColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.lightColor,
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color:
                                          AppTheme.darkColor.withOpacity(0.3),
                                      offset: const Offset(8.0, 8.0),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                    'assets/eva_icons/fill/svg/home.svg',
                                    color: HexColor('#598BFF')),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
