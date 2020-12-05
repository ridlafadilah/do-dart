import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageBottomMenu extends StatelessWidget {
  const LanguageBottomMenu({Key key, this.language}) : super(key: key);

  final String language;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.0,
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Container(
            height: 70.0,
            width: 70.0,
            padding: const EdgeInsets.only(bottom: 15),
            child: FloatingActionButton(
              backgroundColor: AppTheme.white,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              elevation: 0.0,
              highlightElevation: 0.0,
              child: SvgPicture.asset(
                  'assets/eva_icons/outline/svg/close-outline.svg',
                  height: 35.0,
                  width: 35.0,
                  color: AppTheme.grey),
            ),
          ),
          Container(
            height: 210.0,
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
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 24,
                      left: 24,
                      bottom: 15,
                    ),
                    child: Text(
                      'Change Language',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      bottom: 20,
                    ),
                    child: Text(
                      '''
Are you sure want to change the language into $language?''',
                      style: const TextStyle(
                        fontFamily: AppTheme.fontName,
                        wordSpacing: 0.5,
                        height: 1.7,
                      ),
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: 300.0,
                            height: 45.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: const BorderSide(
                                      color: AppTheme.colorTheme, width: 0.5)),
                              color: AppTheme.colorTheme,
                              elevation: 1.0,
                              highlightElevation: 1.0,
                              onPressed: () {},
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
