import 'package:do_dart/auth/page/forgot-password/view/forgot_password_form.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: SizedBox.shrink(),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: ForgotPasswordForm(),
      ),
    );
  }
}
