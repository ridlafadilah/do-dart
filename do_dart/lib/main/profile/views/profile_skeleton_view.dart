import 'package:do_dart/main/profile/widgets/profile_detail_skeleton_widget.dart';
import 'package:do_dart/main/profile/widgets/profile_header_skeleton_widget.dart';
import 'package:do_common/common.dart';
import 'package:flutter/material.dart';

class ProfileSkeletonView extends StatefulWidget {
  ProfileSkeletonView(
      {Key key,
      this.itemTotal,
      this.scrollController,
      this.animationController})
      : super(key: key);

  final int itemTotal;
  final ScrollController scrollController;
  final AnimationController animationController;

  @override
  _ProfileSkeletonViewState createState() => _ProfileSkeletonViewState();
}

class _ProfileSkeletonViewState extends State<ProfileSkeletonView> {
  List<Widget> listWidgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    addList();
  }

  @override
  Widget build(BuildContext context) {
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

  void addList() {
    listWidgets.add(
      ProfileHeaderSkeletonWidget(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / widget.itemTotal) * 0, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listWidgets.add(
      TitleWidget(
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
      ProfileDetailSkeletonWidget(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / widget.itemTotal) * 2, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
  }
}
