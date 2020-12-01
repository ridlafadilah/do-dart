import 'package:do_theme/utils/app_theme.dart';
import 'package:flutter/material.dart';

class DongkapAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DongkapAppBar({
    Key key,
    this.title,
    this.children,
    @required this.animationController,
    @required this.topBarOpacity,
  }) : super(key: key);

  final String title;
  final List<Widget> children;
  final AnimationController animationController;
  final double topBarOpacity;

  @override
  _ProfileAppBarState createState() => _ProfileAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(83 - 19 * topBarOpacity);
}

class _ProfileAppBarState extends State<DongkapAppBar> {
  Animation<double> _topBarAnimation;
  final List<Widget> _children = <Widget>[];

  @override
  void initState() {
    _topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    _children.add(Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.title != null ? widget.title : '',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: AppTheme.fontName,
            fontWeight: FontWeight.w700,
            fontSize: 22 + 6 - 6 * widget.topBarOpacity,
            letterSpacing: 1.2,
            color: AppTheme.darkerText,
          ),
        ),
      ),
    ));
    widget.animationController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: _topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - _topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(widget.topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey
                              .withOpacity(0.3 * widget.topBarOpacity),
                          offset: const Offset(0.1, 0.1),
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
                            top: 16 - 8.0 * widget.topBarOpacity,
                            bottom: 12 - 6.0 * widget.topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.children != null
                              ? widget.children
                              : _children,
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
}
