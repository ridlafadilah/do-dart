import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_dart/auth/page/forgot-password/bloc/request_forgot_password_bloc.dart';
import 'package:do_dart/auth/page/forgot-password/bloc/verification_forgot_password_bloc.dart';
import 'package:do_dart/auth/page/forgot-password/view/verification_forgot_password_page.dart';
import 'package:do_dart/auth/page/login/view/login_page.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:do_dart/l10n/utils/locale_utils.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

class RequestForgotPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestForgotPasswordBloc, RequestForgotPasswordState>(
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
          if (state.verificationId != null) {
            Navigator.of(context).pushAndRemoveUntil<void>(
              MaterialPageRoute(
                builder: (BuildContext context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<VerificationForgotPasswordBloc>(
                        create: (_) => VerificationForgotPasswordBloc(
                            authService:
                                RepositoryProvider.of<AuthService>(context),
                            email: state.email.value,
                            verificationId: state.verificationId),
                      ),
                      BlocProvider<TimerBloc>(
                        create: (_) =>
                            TimerBloc()..add(const TimerStarted(duration: 60)),
                      ),
                    ],
                    child: VerificationForgotPasswordPage(
                        email: state.email.value)),
              ),
              (route) => false,
            );
          }
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
                      const SizedBox(height: 35.0),
                      _EmailInput(),
                      const SizedBox(height: 24.0),
                      _RequestForgotPasswordButton(),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [_LoginLink(), _RegisterLink()],
                      )
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
    return BlocBuilder<RequestForgotPasswordBloc, RequestForgotPasswordState>(
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

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestForgotPasswordBloc, RequestForgotPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('RequestForgotPasswordForm_email'),
          keyboardType: TextInputType.emailAddress,
          autofocus: true,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).email,
            hintText: DongkapLocalizations.of(context).email,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            errorText: state.email.invalid
                ? DongkapLocalizations.of(context).errorEmail
                : null,
          ),
          onChanged: (email) => context
              .read<RequestForgotPasswordBloc>()
              .add(RequestEmailChanged(email)),
        );
      },
    );
  }
}

class _RequestForgotPasswordButton extends StatelessWidget {
  Function _requestForgotPasswordButtonPress(
      BuildContext context, RequestForgotPasswordState state) {
    if (!state.action.isValidated ||
        state.status.isSubmissionInProgress ||
        state.status.isSubmissionSuccess) {
      return null;
    } else {
      return () {
        context
            .read<RequestForgotPasswordBloc>()
            .add(const RequestForgotPasswordEvent());
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestForgotPasswordBloc, RequestForgotPasswordState>(
        buildWhen: (previous, current) => previous.action != current.action,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: RaisedButton(
                onPressed: _requestForgotPasswordButtonPress(context, state),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      DongkapLocalizations.of(context).send.toUpperCase(),
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
        DongkapLocalizations.of(context).labelForgotPasswordRequest,
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

class _RegisterLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 6),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          canRequestFocus: false,
          child: Text(
            DongkapLocalizations.of(context).register,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppTheme.colorTheme,
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
