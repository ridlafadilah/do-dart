import 'package:do_core/core.dart';
import 'package:do_dart/auth/page/login/bloc/login_bloc.dart';
import 'package:do_dart/auth/page/login/view/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: SizedBox.shrink(),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authService: RepositoryProvider.of<AuthService>(context),
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
