import 'package:do_core/models.dart';
import 'package:do_dart/main/profile/widgets/profile_detail_widget.dart';
import 'package:do_dart/main/profile/widgets/profile_header_widget.dart';
import 'package:do_common/common.dart';
import 'package:flutter/material.dart';
import 'package:do_dart/generated/l10n.dart';

class ProfileView extends StatefulWidget {
  ProfileView(
      {Key key,
      this.itemTotal,
      this.scrollController,
      this.animationController,
      @required this.profile})
      : super(key: key);

  final int itemTotal;
  final ScrollController scrollController;
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
  }

  @override
  Widget build(BuildContext context) {
    addList(context);
    return ListView.builder(
      controller: widget.scrollController,
      padding: EdgeInsets.only(
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: widget.itemTotal,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return listWidgets[index];
      },
    );
  }

  void addList(BuildContext context) {
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
      TitleWidget(
        titleTxt: DongkapLocalizations.of(context).titleWidgetProfiletitle,
        subTxt: DongkapLocalizations.of(context).titleWidgetProfileSubtitle,
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
