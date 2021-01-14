import 'package:do_common/common.dart';
import 'package:do_dart/auth/page/login/view/login_page.dart';
import 'package:do_dart/auth/page/register/bloc/register_bloc.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:do_dart/l10n/utils/locale_utils.dart';
import 'package:do_dart/theme/bloc/thememode_bloc.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
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
                      const SizedBox(height: 24.0),
                      _FullnameInput(),
                      const SizedBox(height: 10),
                      _UsernameInput(),
                      const SizedBox(height: 10),
                      _EmailInput(),
                      const SizedBox(height: 10),
                      _PasswordInput(),
                      const SizedBox(height: 10),
                      _ConfirmPasswordInput(),
                      const SizedBox(height: 10),
                      _TermsInput(),
                      const SizedBox(height: 15.0),
                      _RegisterButton(),
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
    return BlocBuilder<RegisterBloc, RegisterState>(
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

class _FullnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.fullname != current.fullname,
      builder: (context, state) {
        return TextFormField(
          key: const Key('RegisterForm_fullname'),
          autofocus: true,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).fullname,
            hintText: DongkapLocalizations.of(context).fullname,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            errorText: state.fullname.invalid
                ? DongkapLocalizations.of(context).errorFullname
                : null,
          ),
          onChanged: (fullname) => context
              .read<RegisterBloc>()
              .add(RegisterFullnameChanged(fullname)),
        );
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          key: const Key('RegisterForm_username'),
          autofocus: true,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).username,
            hintText: DongkapLocalizations.of(context).username,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            errorText: state.username.invalid
                ? DongkapLocalizations.of(context).errorUsername
                : null,
          ),
          onChanged: (username) => context
              .read<RegisterBloc>()
              .add(RegisterUsernameChanged(username)),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('RegisterForm_email'),
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
          onChanged: (email) =>
              context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  __PasswordInputState createState() => __PasswordInputState();
}

class __PasswordInputState extends State<_PasswordInput> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          key: const Key('RegisterForm_password'),
          autofocus: false,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).password,
            hintText: DongkapLocalizations.of(context).password,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            errorText: state.password.invalid
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
              .read<RegisterBloc>()
              .add(RegisterPasswordChanged(password)),
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return TextFormField(
          key: const Key('RegisterForm_confirmPassword'),
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
              .read<RegisterBloc>()
              .add(RegisterConfirmPasswordChanged(password)),
        );
      },
    );
  }
}

class _TermsInput extends StatefulWidget {
  @override
  __TermsInputState createState() => __TermsInputState();
}

class __TermsInputState extends State<_TermsInput> {
  bool isTerms = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                  key: const Key('RegisterForm_terms'),
                  value: isTerms,
                  activeColor: AppTheme.colorTheme,
                  onChanged: (bool value) {
                    if (value) {
                      _capthcaShow(context);
                    } else {
                      setState(() {
                        isTerms = false;
                      });
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Text(
                    DongkapLocalizations.of(context).labelTermsRegister,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  canRequestFocus: false,
                  child: Text(
                    DongkapLocalizations.of(context).termsAndConditions,
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
      },
    );
  }

  void _capthcaShow(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Center(
          child: RecaptchaV2(
            siteKey: '6LdQB9YZAAAAAI12Oyn9yoi5BoW0Bivxo8vJl8rd',
            dark: context.read<ThemeModeBloc>().state.darkMode,
            onChanged: (String value) {
              context.read<RegisterBloc>().add(RegisterCaptchaChanged(value));
              setState(() {
                isTerms = true;
              });
            },
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  Function _registerButtonPress(BuildContext context, RegisterState state) {
    if (!state.action.isValidated ||
        state.status.isSubmissionInProgress ||
        state.status.isSubmissionSuccess) {
      return null;
    } else {
      return () {
        context.read<RegisterBloc>().add(const RegisterEvent());
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
        buildWhen: (previous, current) => previous.action != current.action,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: RaisedButton(
                onPressed: _registerButtonPress(context, state),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      DongkapLocalizations.of(context).register.toUpperCase(),
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
        DongkapLocalizations.of(context).register,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w700,
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
