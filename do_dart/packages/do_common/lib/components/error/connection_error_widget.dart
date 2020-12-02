import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConnectionErrorWidget extends StatelessWidget {
  ConnectionErrorWidget({
    Key key,
    @required this.error,
    @required this.onPressed,
  }) : super(key: key);

  final String error;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 35,
            width: 35,
            child: SvgPicture.asset(
                'assets/eva_icons/outline/svg/alert-triangle-outline.svg',
                color: AppTheme.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              error,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.grey,
              ),
            ),
          ),
          RaisedButton(
            color: AppTheme.colorTheme,
            onPressed: onPressed,
            child: const Text(
              'Retry',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.white,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}
