import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_dart/main/security/bloc/change_password_bloc.dart';
import 'package:do_dart/l10n/utils/locale_utils.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget(
      {Key key, this.animationController, this.scaffoldMessengerKey})
      : super(key: key);

  final AnimationController animationController;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ChangePasswordBloc(
          authService: RepositoryProvider.of<AuthService>(context),
        );
      },
      child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            Flushbar(
              messageText: Text(
                LocaleUtils.translate(state.error),
                style: const TextStyle(color: Colors.white),
              ),
              icon: SvgPicture.asset(
                  'assets/eva_icons/outline/svg/alert-triangle-outline.svg',
                  color: Colors.white),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red[400],
              routeBlur: 0.5,
              isDismissible: false,
              dismissDirection: FlushbarDismissDirection.vertical,
            )..show(context);
          }
        },
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _LinearProgressIndicator(),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  _OldPasswordInput(),
                  const SizedBox(height: 10),
                  _NewPasswordInput(),
                  const SizedBox(height: 10),
                  _ConfirmPasswordInput(),
                  const SizedBox(height: 10),
                  _ButtonChangePasswordInput(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinearProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) => previous.action != current.action,
      builder: (context, state) {
        if (!state.status.isSubmissionInProgress) {
          return const SizedBox(
            height: 4.0,
          );
        } else {
          return const LinearProgressIndicator(
            backgroundColor: AppTheme.colorTheme,
          );
        }
      },
    );
  }
}

class _OldPasswordInput extends StatefulWidget {
  @override
  __OldPasswordInputState createState() => __OldPasswordInputState();
}

class __OldPasswordInputState extends State<_OldPasswordInput> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.oldPassword != current.oldPassword,
      builder: (context, state) {
        return TextFormField(
          key: const Key('changePasswordForm_currentPassword'),
          autofocus: false,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).password,
            hintText: DongkapLocalizations.of(context).password,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            errorText: state.oldPassword.invalid
                ? DongkapLocalizations.of(context).errorPassword
                : null,
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
          onChanged: (password) => context
              .read<ChangePasswordBloc>()
              .add(OldPasswordChanged(password)),
        );
      },
    );
  }
}

class _NewPasswordInput extends StatefulWidget {
  @override
  __NewPasswordInputState createState() => __NewPasswordInputState();
}

class __NewPasswordInputState extends State<_NewPasswordInput> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.newPassword != current.newPassword,
      builder: (context, state) {
        return TextFormField(
          key: const Key('changePasswordForm_newPassword'),
          autofocus: false,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).newPassword,
            hintText: DongkapLocalizations.of(context).newPassword,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            errorText: state.newPassword.invalid
                ? DongkapLocalizations.of(context).errorNewPassword
                : null,
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
          onChanged: (password) => context
              .read<ChangePasswordBloc>()
              .add(NewPasswordChanged(password)),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatefulWidget {
  @override
  __ConfirmPasswordInputState createState() => __ConfirmPasswordInputState();
}

class __ConfirmPasswordInputState extends State<_ConfirmPasswordInput> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return TextFormField(
          key: const Key('changePasswordForm_confirmPassword'),
          autofocus: false,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).confirmPassword,
            hintText: DongkapLocalizations.of(context).confirmPassword,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            errorText: state.confirmPassword.invalid
                ? DongkapLocalizations.of(context).errorConfirmPassword
                : null,
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
          onChanged: (password) => context
              .read<ChangePasswordBloc>()
              .add(ConfirmPasswordChanged(password)),
        );
      },
    );
  }
}

class _ButtonChangePasswordInput extends StatelessWidget {
  Function _changePasswordButtonPress(
      BuildContext context, ChangePasswordState state) {
    if (!state.action.isValidated || state.status.isSubmissionInProgress) {
      return null;
    } else {
      return () {
        context.read<ChangePasswordBloc>().add(const SubmittedEvent());
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) => previous.action != current.action,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: Container(
              decoration: state.status.isSubmissionInProgress
                  ? null
                  : BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: const Offset(2, 2),
                            blurRadius: 2.0),
                      ],
                    ),
              child: ButtonTheme(
                minWidth: 200.0,
                height: 48.0,
                child: RaisedButton(
                  color: AppTheme.button,
                  disabledColor: AppTheme.buttonDisable,
                  onPressed: _changePasswordButtonPress(context, state),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        DongkapLocalizations.of(context).changePassword,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: state.status.isSubmissionInProgress
                              ? AppTheme.buttonTextDisable
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
