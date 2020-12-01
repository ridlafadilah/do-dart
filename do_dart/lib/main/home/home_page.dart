import 'package:do_dart/main/home/widgets/home_widget.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
      HomeWidget(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: const Interval((1 / count) * 0, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController),
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

  Widget appBar() {
    return DongkapAppBar(
      animationController: widget.animationController,
      topBarOpacity: _topBarOpacity,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Dongkap',
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
              onTap: () {},
              child: Center(
                child: SvgPicture.asset(
                    'assets/eva_icons/outline/svg/bell-outline.svg'),
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
              splashColor: AppTheme.grey,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              onTap: () {},
              child: Center(
                child: ClipOval(
                  child: Image.asset('assets/avatars/default.png'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
