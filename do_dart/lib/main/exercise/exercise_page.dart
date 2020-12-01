import 'package:do_dart/main/exercise/widgets/exercise_badge_widget.dart';
import 'package:flutter/material.dart';

import 'package:do_theme/theme.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage>
    with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];
  final ScrollController _scrollController = ScrollController();
  double _topBarOpacity = 0.0;

  @override
  void initState() {
    addAllListData();

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

  void addAllListData() {
    const int count = 1;
    listViews.add(
      ExerciseBadgeWidget(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval((1 / count) * 0, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
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
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget appBar() {
    return DongkapAppBar(
      animationController: widget.animationController,
      topBarOpacity: _topBarOpacity,
      title: 'Exercise',
    );
  }
}
