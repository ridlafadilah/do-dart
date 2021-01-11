import 'package:do_dart/auth/page/forgot-password/view/verification_forgot_password_form.dart';
import 'package:flutter/material.dart';

class VerificationForgotPasswordPage extends StatefulWidget {
  const VerificationForgotPasswordPage({Key key, this.email}) : super(key: key);

  final String email;

  @override
  _VerificationForgotPasswordPageState createState() =>
      _VerificationForgotPasswordPageState();
}

class _VerificationForgotPasswordPageState
    extends State<VerificationForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: SizedBox.shrink(),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: VerificationForgotPasswordForm(email: widget.email),
      ),
    );
  }
}
