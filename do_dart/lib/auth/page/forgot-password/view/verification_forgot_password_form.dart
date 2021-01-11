import 'dart:async';

import 'package:do_common/common.dart';
import 'package:do_core/core.dart';
import 'package:do_dart/auth/page/login/view/login_page.dart';
import 'package:do_dart/auth/page/forgot-password/bloc/forgot_password_bloc.dart';
import 'package:do_dart/auth/page/forgot-password/bloc/verification_forgot_password_bloc.dart';
import 'package:do_dart/auth/page/forgot-password/view/forgot_password_page.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:do_dart/l10n/utils/locale_utils.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

class VerificationForgotPasswordForm extends StatefulWidget {
  const VerificationForgotPasswordForm({Key key, this.email}) : super(key: key);

  final String email;

  @override
  _VerificationForgotPasswordFormState createState() =>
      _VerificationForgotPasswordFormState();
}

class _VerificationForgotPasswordFormState
    extends State<VerificationForgotPasswordForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationForgotPasswordBloc,
        VerificationForgotPasswordState>(
      listener: (context, state) {
        if (state.action.isSubmissionFailure) {
          Flushbar(
            messageText: Text(
              LocaleUtils.translate(
                  LocaleUtils.translate(StringUtils.toCamelCase(state.error))),
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
                builder: (BuildContext context) => BlocProvider(
                  create: (BuildContext context) => ForgotPasswordBloc(
                      authService: RepositoryProvider.of<AuthService>(context),
                      verificationId: state.verificationId,
                      verificationCode: state.verificationCode.value),
                  child: ForgotPasswordPage(),
                ),
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
                      _SubtitleLabel(email: widget.email),
                      const SizedBox(height: 35.0),
                      _PinInput(),
                      const SizedBox(height: 24.0),
                      _Resend(),
                      const SizedBox(height: 20.0),
                      _VerificationForgotPasswordButton(),
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
    return BlocBuilder<VerificationForgotPasswordBloc,
        VerificationForgotPasswordState>(
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

class _PinInput extends StatefulWidget {
  @override
  __PinInputState createState() => __PinInputState();
}

class __PinInputState extends State<_PinInput> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationForgotPasswordBloc,
        VerificationForgotPasswordState>(
      buildWhen: (previous, current) =>
          previous.verificationCode != current.verificationCode,
      builder: (context, state) {
        return PinCodeTextField(
          appContext: context,
          length: 6,
          obscureText: false,
          autoFocus: true,
          obscuringCharacter: '*',
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: AppTheme.lightColor,
              inactiveColor: AppTheme.lightGrey,
              selectedColor: AppTheme.grey,
              activeColor: AppTheme.lightGrey,
              inactiveFillColor: AppTheme.lightGrey,
              selectedFillColor: AppTheme.lightColor),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          textStyle: const TextStyle(fontSize: 20, height: 1.6),
          enableActiveFill: true,
          errorAnimationController: errorController,
          controller: textEditingController,
          keyboardType: TextInputType.number,
          onChanged: (String verificationCode) => context
              .read<VerificationForgotPasswordBloc>()
              .add(VerificationCodeChanged(verificationCode)),
        );
      },
    );
  }
}

class _VerificationForgotPasswordButton extends StatelessWidget {
  Function _verificationForgotPasswordButtonPress(
      BuildContext context, VerificationForgotPasswordState state) {
    if (!state.action.isValidated ||
        state.status.isSubmissionInProgress ||
        state.status.isSubmissionSuccess) {
      return null;
    } else {
      return () {
        context
            .read<VerificationForgotPasswordBloc>()
            .add(const VerificationForgotPasswordEvent());
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationForgotPasswordBloc,
            VerificationForgotPasswordState>(
        buildWhen: (previous, current) => previous.action != current.action,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: RaisedButton(
                onPressed:
                    _verificationForgotPasswordButtonPress(context, state),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      DongkapLocalizations.of(context).verify.toUpperCase(),
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
        DongkapLocalizations.of(context).forgotPasswordVerification,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SubtitleLabel extends StatefulWidget {
  const _SubtitleLabel({Key key, this.email}) : super(key: key);

  final String email;
  @override
  __SubtitleLabelState createState() => __SubtitleLabelState();
}

class __SubtitleLabelState extends State<_SubtitleLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        DongkapLocalizations.of(context)
            .labelForgotPasswordVerification(widget.email),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _Resend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Text(
                  DongkapLocalizations.of(context).labelForgotPasswordResend,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            InkWell(
              onTap: () {},
              canRequestFocus: false,
              child: Text(
                DongkapLocalizations.of(context).resend,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.colorTheme,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ]),
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
