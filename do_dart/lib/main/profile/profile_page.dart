import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_dart/main/profile/bloc/profile_bloc.dart';
import 'package:do_dart/main/profile/profile_bottom_menu.dart';
import 'package:do_dart/main/profile/views/profile_skeleton_view.dart';
import 'package:do_dart/main/profile/views/profile_view.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          if (state is SuccessState) {
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
          } else if (state is FailureState) {
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
          return ProfileBottomMenu(
              animationController: widget.animationController);
        });
  }
}
