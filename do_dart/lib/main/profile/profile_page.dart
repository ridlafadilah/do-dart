import 'package:do_core/core.dart';
import 'package:do_dart/main/about/about_page.dart';
import 'package:do_dart/main/profile/bloc/profile_bloc.dart';
import 'package:do_dart/main/profile/views/profile_skeleton_view.dart';
import 'package:do_dart/main/profile/views/profile_view.dart';
import 'package:do_dart/main/security/security_page.dart';
import 'package:do_dart/main/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:do_theme/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  final ScrollController _scrollController = ScrollController();
  double _topBarOpacity = 0.0;
  final int _itemTotal = 3;

  @override
  void initState() {
    super.initState();

    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    _scrollController.addListener(() {
      if (_scrollController.offset >= 24) {
        if (_topBarOpacity != 1.0) {
          setState(() {
            _topBarOpacity = 1.0;
          });
        }
      } else if (_scrollController.offset <= 24 &&
          _scrollController.offset >= 0) {
        if (_topBarOpacity != _scrollController.offset / 24) {
          setState(() {
            _topBarOpacity = _scrollController.offset / 24;
          });
        }
      } else if (_scrollController.offset <= 0) {
        if (_topBarOpacity != 0.0) {
          setState(() {
            _topBarOpacity = 0.0;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            mainView(),
            appBar(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget mainView() {
    return BlocProvider(
      create: (context) {
        return ProfileBloc(
          authService: RepositoryProvider.of<AuthService>(context),
        )..add(const ProfileFetched());
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (BuildContext context, ProfileState state) {
          if (state is ProfileSuccess) {
            return ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.only(
                top: AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top +
                    24,
                bottom: 62 + MediaQuery.of(context).padding.bottom,
              ),
              itemCount: _itemTotal,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return ProfileView(
                    itemTotal: _itemTotal,
                    index: index,
                    animationController: widget.animationController,
                    profile: state.profile);
              },
            );
          } else {
            return ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.only(
                top: AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top +
                    24,
                bottom: 62 + MediaQuery.of(context).padding.bottom,
              ),
              itemCount: _itemTotal,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return ProfileSkeletonView(
                    itemTotal: _itemTotal,
                    index: index,
                    animationController: widget.animationController);
              },
            );
          }
        },
      ),
    );
  }

  Widget appBar() {
    widget.animationController.forward();
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(_topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color:
                              AppTheme.grey.withOpacity(0.4 * _topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * _topBarOpacity,
                            bottom: 12 - 8.0 * _topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Account',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * _topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: AppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  _modalBottomSheetMenu();
                                },
                                child: Container(
                                  height: 44,
                                  width: 40,
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                          'assets/eva_icons/outline/svg/menu-2-outline.svg'),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  void _modalBottomSheetMenu() async {
    await showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            height: 300.0,
            color: Colors.transparent,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: SvgPicture.asset(
                        'assets/eva_icons/outline/svg/settings-outline.svg'),
                    title: const Text('Settings'),
                    horizontalTitleGap: 2,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => SettingsPage(
                                animationController:
                                    widget.animationController)),
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1.0,
                    indent: 65,
                    endIndent: 10,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                        'assets/eva_icons/outline/svg/lock-outline.svg'),
                    title: const Text('Security'),
                    horizontalTitleGap: 2,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => SecurityPage(
                                animationController:
                                    widget.animationController)),
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1.0,
                    indent: 65,
                    endIndent: 10,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                        'assets/eva_icons/outline/svg/info-outline.svg'),
                    title: const Text('About'),
                    horizontalTitleGap: 2,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => AboutPage(
                                animationController:
                                    widget.animationController)),
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1.0,
                    indent: 65,
                    endIndent: 10,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                        'assets/eva_icons/outline/svg/power-outline.svg'),
                    title: const Text('Logout'),
                    horizontalTitleGap: 2,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    onTap: () async {
                      AuthService authService =
                          RepositoryProvider.of<AuthService>(context);
                      await authService.logOut();
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1.0,
                    indent: 65,
                    endIndent: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
