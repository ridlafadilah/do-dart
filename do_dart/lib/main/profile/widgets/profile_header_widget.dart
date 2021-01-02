import 'dart:io';

import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:do_dart/main/profile/bloc/photo_profile_bloc.dart';
import 'package:do_dart/widgets/camera_widget.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget(
      {Key key,
      this.animationController,
      this.animation,
      this.profile,
      this.navigatorState})
      : super(key: key);

  final AnimationController animationController;
  final Animation animation;
  final ProfileDto profile;
  final NavigatorState navigatorState;

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
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Theme.of(context)
                                      .cardTheme
                                      .shadowColor
                                      .withOpacity(0.2),
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 130,
                                        right: 16,
                                        top: 16,
                                      ),
                                      child: Text(
                                        profile.name,
                                        softWrap: false,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: -0.2,
                                        ),
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
                                        profile.email,
                                        softWrap: false,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .color
                                              .withOpacity(0.5),
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
                        child: _PhotoProfile(
                          animationController: animationController,
                          navigatorState: navigatorState,
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

class _PhotoProfile extends StatefulWidget {
  const _PhotoProfile({Key key, this.animationController, this.navigatorState})
      : super(key: key);

  final AnimationController animationController;
  final NavigatorState navigatorState;

  @override
  __PhotoProfileState createState() => __PhotoProfileState();
}

class __PhotoProfileState extends State<_PhotoProfile> {
  String path;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoProfileBloc, CommonState>(
      builder: (context, state) {
        if (state is RequestInProgressState) {
          return const SkeletonRound();
        } else {
          Widget _imageAvatar = const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/avatars/default.png'),
          );
          if (state is RequestSuccessState<String>) {
            if (state.data != null) {
              _imageAvatar = CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(File(state.data)),
              );
            }
          }
          return Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppTheme.darkBlueGrey.withOpacity(0.1),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 5.0),
              ],
            ),
            padding: const EdgeInsets.only(left: 5),
            child: Stack(
              children: <Widget>[
                _imageAvatar,
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .accentIconTheme
                          .color
                          .withOpacity(0.5),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Theme.of(context)
                                .accentIconTheme
                                .color
                                .withOpacity(0.1),
                            offset: const Offset(1.0, 1.0),
                            blurRadius: 5.0),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          highlightColor: Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          onTap: () {
                            openCamera();
                          },
                          child: SvgPicture.asset(
                              'assets/eva_icons/fill/svg/camera.svg',
                              color: Theme.of(context).iconTheme.color),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void openCamera() {
    FocusScope.of(context).requestFocus(FocusNode());
    widget.navigatorState
        .push(MaterialPageRoute(
      builder: (BuildContext context) => BlocProvider(
        create: (BuildContext context) => CameraBloc(
            cameraUtils: CameraUtils(),
            authService: RepositoryProvider.of<AuthService>(context))
          ..add(const CameraInitializedEvent()),
        child:
            CameraScreen(header: DongkapLocalizations.of(context).photoProfile),
      ),
    ))
        .then((value) {
      if (value is String) setState(() => path = value);
    });
  }
}
