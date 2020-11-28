import 'package:do_core/models.dart';
import 'package:do_dart/main/profile/widget/profile_detail_widget.dart';
import 'package:do_dart/main/profile/widget/profile_header_widget.dart';
import 'package:do_theme/components/views/title_view.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  ProfileView(
      {Key key,
      this.index,
      this.itemTotal,
      this.animationController,
      @required this.profile})
      : super(key: key);

  final int itemTotal;
  final int index;
  final AnimationController animationController;
  final ProfileDto profile;

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<Widget> listWidgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    addList();
  }

  @override
  Widget build(BuildContext context) {
    return listWidgets[widget.index];
  }

  void addList() {
    listWidgets.add(
      ProfileHeaderWidget(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / widget.itemTotal) * 0, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        profile: widget.profile,
      ),
    );

    listWidgets.add(
      TitleView(
        titleTxt: 'Your Profile',
        subTxt: 'Customize',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / widget.itemTotal) * 1, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        onTap: () {},
      ),
    );

    listWidgets.add(
      ProfileDetailWidget(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / widget.itemTotal) * 2, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        profile: widget.profile,
      ),
    );
  }
}
