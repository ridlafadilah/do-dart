import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget(
      {Key key, this.animationController, this.animation})
      : super(key: key);

  final AnimationController animationController;
  final Animation animation;

  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  bool is2FA = false;
  String is2FAIcon = 'assets/eva_icons/outline/svg/shield-off-outline.svg';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: <Widget>[
          TextFormField(
            key: const Key('changePasswordForm_currentPassword'),
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Current Password',
              hintText: 'Current Password',
              contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            onChanged: (password) {},
          ),
          const SizedBox(height: 10),
          TextFormField(
            key: const Key('changePasswordForm_newPassword'),
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'New Password',
              hintText: 'New Password',
              contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            onChanged: (password) {},
          ),
          const SizedBox(height: 10),
          TextFormField(
            key: const Key('changePasswordForm_confirmPassword'),
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Confirm Password',
              contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            onChanged: (password) {},
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(2, 2),
                        blurRadius: 2.0),
                  ],
                ),
                child: MaterialButton(
                  color: AppTheme.button,
                  disabledColor: AppTheme.buttonDisable,
                  minWidth: 200.0,
                  height: 48.0,
                  onPressed: () {},
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'Change Password',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
