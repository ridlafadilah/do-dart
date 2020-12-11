import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeactivateDialogBottomSheet extends StatefulWidget {
  DeactivateDialogBottomSheet({Key key, this.onSubmit}) : super(key: key);

  final void Function() onSubmit;

  @override
  _DeactivateDialogBottomSheetState createState() =>
      _DeactivateDialogBottomSheetState();
}

class _DeactivateDialogBottomSheetState
    extends State<DeactivateDialogBottomSheet> {
  final String title = 'Deactivate Account';
  final String subtitle = '''
This action cannot be undone. This will permanently disable your account.\nI understand the consequences''';
  final String submit = 'Deactivate Account';
  final double sizeExitButton = 70.0;
  final double height = 370.0;
  bool isObscureText = true;
  bool buttonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).viewInsets.bottom + height,
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Container(
            height: sizeExitButton,
            width: sizeExitButton,
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
            height: height - sizeExitButton,
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
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 24,
                      left: 24,
                      bottom: 15,
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
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
                      subtitle,
                      style: const TextStyle(
                        fontFamily: AppTheme.fontName,
                        wordSpacing: 0.5,
                        height: 1.7,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 15.0),
                    child: TextFormField(
                      key: const Key('deactivateAccountForm_password'),
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password',
                        contentPadding:
                            const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isObscureText = !isObscureText;
                              });
                            },
                            child: isObscureText
                                ? SvgPicture.asset(
                                    'assets/eva_icons/outline/svg/eye-outline.svg',
                                    color: AppTheme.grey.withOpacity(0.85))
                                : SvgPicture.asset(
                                    'assets/eva_icons/outline/svg/eye-off-outline.svg',
                                    color: AppTheme.grey.withOpacity(0.85)),
                          ),
                        ),
                      ),
                      obscureText: isObscureText,
                    ),
                  ),
                  _buttonSubmitModal(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonSubmitModal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: ButtonTheme(
          minWidth: 400.0,
          height: 45.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(
                    color: buttonDisabled ? AppTheme.buttonDisable : Colors.red,
                    width: 0.5)),
            color: Colors.red,
            disabledColor: AppTheme.buttonDisable,
            elevation: 1.0,
            highlightElevation: 1.0,
            onPressed: widget.onSubmit,
            child: Text(
              submit,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color:
                    buttonDisabled ? AppTheme.buttonTextDisable : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
