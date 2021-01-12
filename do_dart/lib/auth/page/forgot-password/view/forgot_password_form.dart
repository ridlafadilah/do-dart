import 'package:do_common/common.dart';
import 'package:do_dart/auth/page/login/view/login_page.dart';
import 'package:do_dart/auth/page/forgot-password/bloc/forgot_password_bloc.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:do_dart/l10n/utils/locale_utils.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.action.isSubmissionFailure) {
          Flushbar(
            messageText: Text(
              LocaleUtils.translate(LocaleUtils.translate(state.error)),
              style: const TextStyle(color: Colors.white),
            ),
            icon: SvgPicture.asset(
                'assets/eva_icons/outline/svg/alert-triangle-outline.svg',
                color: AppTheme.lightColor),
            duration: const Duration(seconds: 3),
            backgroundColor: AppTheme.lightDanger,
            isDismissible: false,
            dismissDirection: FlushbarDismissDirection.VERTICAL,
          )..show(context);
        }
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pushAndRemoveUntil<void>(
            LoginPage.route(),
            (route) => false,
          );
        }
      },
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: _LinearProgressIndicator(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30.0),
                      _TitleLabel(),
                      const SizedBox(height: 8.0),
                      _SubtitleLabel(),
                      const SizedBox(height: 24.0),
                      _NewPasswordInput(),
                      const SizedBox(height: 10),
                      _ConfirmPasswordInput(),
                      const SizedBox(height: 15.0),
                      _ForgotPasswordButton(),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [_LoginLink()],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LinearProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.action != current.action,
      builder: (context, state) {
        if (state.status.isSubmissionInProgress) {
          return const LinearProgressIndicator();
        } else if (state.status.isSubmissionSuccess) {
          return const LinearProgressIndicator(value: 100);
        } else {
          return const SizedBox(
            height: 4.0,
          );
        }
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
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) =>
          previous.newPassword != current.newPassword,
      builder: (context, state) {
        return TextFormField(
          key: const Key('forgotPasswordForm_newPassword'),
          autofocus: false,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).newPassword,
            hintText: DongkapLocalizations.of(context).newPassword,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
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
                        color:
                            Theme.of(context).iconTheme.color.withOpacity(0.5))
                    : SvgPicture.asset(
                        'assets/eva_icons/outline/svg/eye-off-outline.svg',
                        color:
                            Theme.of(context).iconTheme.color.withOpacity(0.5)),
              ),
            ),
          ),
          obscureText: isObscureText,
          onChanged: (password) => context
              .read<ForgotPasswordBloc>()
              .add(ForgotPasswordNewPasswordChanged(password)),
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
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return TextFormField(
          key: const Key('forgotPasswordForm_confirmPassword'),
          autofocus: false,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).confirmPassword,
            hintText: DongkapLocalizations.of(context).confirmPassword,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
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
                        color:
                            Theme.of(context).iconTheme.color.withOpacity(0.5))
                    : SvgPicture.asset(
                        'assets/eva_icons/outline/svg/eye-off-outline.svg',
                        color:
                            Theme.of(context).iconTheme.color.withOpacity(0.5)),
              ),
            ),
          ),
          obscureText: isObscureText,
          onChanged: (password) => context
              .read<ForgotPasswordBloc>()
              .add(ForgotPasswordConfirmPasswordChanged(password)),
        );
      },
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  Function _forgotPasswordButtonPress(
      BuildContext context, ForgotPasswordState state) {
    if (!state.action.isValidated ||
        state.status.isSubmissionInProgress ||
        state.status.isSubmissionSuccess) {
      return null;
    } else {
      return () {
        context.read<ForgotPasswordBloc>().add(const ForgotPasswordEvent());
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        buildWhen: (previous, current) => previous.action != current.action,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: RaisedButton(
                onPressed: _forgotPasswordButtonPress(context, state),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      DongkapLocalizations.of(context)
                          .buttonSubmit
                          .toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: (state.status.isSubmissionInProgress ||
                                state.action.isInvalid ||
                                state.action.isPure)
                            ? AppTheme.buttonTextDisable
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class _TitleLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        DongkapLocalizations.of(context).forgotPassword,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SubtitleLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        DongkapLocalizations.of(context).labelForgotPassword,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _LoginLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 6),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          canRequestFocus: false,
          child: Text(
            DongkapLocalizations.of(context).labelBackToLogin,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppTheme.colorTheme,
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil<void>(
              LoginPage.route(),
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}
