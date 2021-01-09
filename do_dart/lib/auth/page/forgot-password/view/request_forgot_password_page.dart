import 'package:do_core/core.dart';
import 'package:do_dart/auth/page/forgot-password/bloc/forgot_password_bloc.dart';
import 'package:do_dart/auth/page/forgot-password/view/request_forgot_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestForgotPasswordPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RequestForgotPasswordPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: SizedBox.shrink(),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: BlocProvider(
          create: (context) {
            return ForgotPasswordBloc(
              authService: RepositoryProvider.of<AuthService>(context),
            );
          },
          child: ForgotPasswordForm(),
        ),
      ),
    );
  }
}
