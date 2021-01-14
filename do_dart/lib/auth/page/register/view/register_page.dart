import 'package:do_core/core.dart';
import 'package:do_dart/auth/page/register/bloc/register_bloc.dart';
import 'package:do_dart/auth/page/register/view/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegisterPage());
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
            return RegisterBloc(
              authService: RepositoryProvider.of<AuthService>(context),
            );
          },
          child: RegisterForm(),
        ),
      ),
    );
  }
}
