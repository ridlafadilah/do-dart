import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_dart/main/about/about_page.dart';
import 'package:do_dart/main/profile/bloc/profile_bloc.dart';
import 'package:do_dart/main/profile/views/profile_skeleton_view.dart';
import 'package:do_dart/main/profile/views/profile_view.dart';
import 'package:do_dart/main/security/security_page.dart';
import 'package:do_dart/main/settings/settings_page.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double _topBarOpacity = 0.0;
  final int _itemTotal = 3;

  @override
  void initState() {
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: appBar(),
        body: Stack(
          children: <Widget>[
            mainView(),
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
        )..add(const RequestedEvent());
      },
      child: BlocBuilder<ProfileBloc, CommonState>(
        builder: (BuildContext context, CommonState state) {
          if (state is RequestSuccessState<ProfileDto>) {
            return RefreshIndicator(
              backgroundColor: Colors.white,
              color: AppTheme.colorTheme,
              strokeWidth: 3,
              child: ProfileView(
                  itemTotal: _itemTotal,
                  scrollController: _scrollController,
                  animationController: widget.animationController,
                  profile: state.data),
              onRefresh: () async {
                context.read<ProfileBloc>().add(const RequestedEvent());
              },
            );
          } else if (state is RequestFailureState) {
            return ConnectionErrorWidget(
                error: state.error,
                onPressed: () async {
                  context.read<ProfileBloc>().add(const RequestedEvent());
                });
          } else {
            return ProfileSkeletonView(
                itemTotal: _itemTotal,
                scrollController: _scrollController,
                animationController: widget.animationController);
          }
        },
      ),
    );
  }

  Widget appBar() {
    return DongkapAppBar(
      animationController: widget.animationController,
      topBarOpacity: _topBarOpacity,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context).account,
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
          child: SizedBox(
            height: 40,
            width: 40,
            child: InkWell(
              highlightColor: AppTheme.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              onTap: () {
                _modalBottomSheetMenu(context);
              },
              child: Center(
                child: SvgPicture.asset(
                    'assets/eva_icons/outline/svg/menu-2-outline.svg'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _modalBottomSheetMenu(BuildContext context) async {
    await showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            height: 300.0,
            color: Colors.transparent,
            child: Card(
              color: Colors.white,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              borderOnForeground: true,
              elevation: 0,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                    title: Text(
                      AppLocalizations.of(context).settings,
                      style: const TextStyle(fontFamily: AppTheme.fontName),
                    ),
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
                    title: Text(
                      AppLocalizations.of(context).security,
                      style: const TextStyle(fontFamily: AppTheme.fontName),
                    ),
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
                    title: Text(
                      AppLocalizations.of(context).about,
                      style: const TextStyle(fontFamily: AppTheme.fontName),
                    ),
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
                    title: Text(
                      AppLocalizations.of(context).logout,
                      style: const TextStyle(fontFamily: AppTheme.fontName),
                    ),
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
