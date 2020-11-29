import 'package:do_common/common.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';

class ProfileHeaderSkeletonWidget extends StatelessWidget {
  const ProfileHeaderSkeletonWidget(
      {Key key, this.animationController, this.animation})
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
                                      child: Skeleton(height: 14),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 130,
                                        bottom: 25,
                                        top: 4,
                                        right: 16,
                                      ),
                                      child: Skeleton(
                                          height: 12,
                                          margin: EdgeInsets.only(top: 5)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        top: -20,
                        left: 15,
                        child: SkeletonRound(),
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
