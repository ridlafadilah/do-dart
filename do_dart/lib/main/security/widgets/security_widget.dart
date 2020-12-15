import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_dart/main/security/bloc/provider_bloc.dart';
import 'package:do_dart/main/security/bloc/two_factor_auth_bloc.dart';
import 'package:do_dart/main/security/change_password_page.dart';
import 'package:do_dart/main/security/deactivate_account_page.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecurityWidget extends StatefulWidget {
  const SecurityWidget({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  _SecurityWidgetState createState() => _SecurityWidgetState();
}

class _SecurityWidgetState extends State<SecurityWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProviderBloc()..add(const ProviderEvent());
      },
      child: BlocBuilder<ProviderBloc, CommonState>(
        builder: (BuildContext context, CommonState state) {
          if (state is SocialState) {
            return _social(state.provider);
          } else {
            return _local();
          }
        },
      ),
    );
  }

  Widget _social(String provider) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            enabled: false,
            leading: SvgPicture.asset('assets/eva_icons/fill/svg/google.svg'),
            title: Text(
              DongkapLocalizations.of(context).labelLoginSocial('Google'),
              style: const TextStyle(
                  fontFamily: AppTheme.fontName, color: Colors.black),
            ),
            horizontalTitleGap: 2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            onTap: () {},
          ),
          const Divider(
            height: 1,
            thickness: 1.0,
            indent: 60,
          ),
          ListTile(
            leading: SvgPicture.asset(
                'assets/eva_icons/outline/svg/slash-outline.svg'),
            title: Text(
              DongkapLocalizations.of(context).deactivateAccount,
              style: const TextStyle(fontFamily: AppTheme.fontName),
            ),
            horizontalTitleGap: 2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            trailing: SvgPicture.asset(
                'assets/eva_icons/outline/svg/arrow-ios-forward-outline.svg'),
            onTap: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => DeactivateAccountPage(
                        animationController: widget.animationController)),
              );
            },
          ),
          const Divider(
            height: 1,
            thickness: 1.0,
            indent: 60,
          ),
        ],
      ),
    );
  }

  Widget _local() {
    bool is2FA = false;
    String is2FAIcon = 'assets/eva_icons/outline/svg/shield-off-outline.svg';
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            leading: SvgPicture.asset(
                'assets/eva_icons/outline/svg/lock-outline.svg'),
            title: Text(
              DongkapLocalizations.of(context).changePassword,
              style: const TextStyle(fontFamily: AppTheme.fontName),
            ),
            horizontalTitleGap: 2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            trailing: SvgPicture.asset(
                'assets/eva_icons/outline/svg/arrow-ios-forward-outline.svg'),
            onTap: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => ChangePasswordPage(
                        animationController: widget.animationController)),
              );
            },
          ),
          const Divider(
            height: 1,
            thickness: 1.0,
            indent: 60,
          ),
          BlocProvider(
            create: (context) {
              return TwoFactorAuthenticationBloc()..add(const RequestedEvent());
            },
            child: BlocListener<TwoFactorAuthenticationBloc, CommonState>(
              listener: (context, state) {
                if (state is RequestSuccessState<bool>) {
                  is2FA = state.data;
                  is2FAIcon = state.data
                      ? 'assets/eva_icons/outline/svg/shield-outline.svg'
                      : 'assets/eva_icons/outline/svg/shield-off-outline.svg';
                }
                if (state is SubmitInProgressState) {
                  _loading(context);
                } else if (state is SubmitFailureState) {
                  Navigator.of(context, rootNavigator: true).pop();
                } else if (state is SubmitSuccessState<bool>) {
                  Navigator.of(context, rootNavigator: true).pop();
                  is2FA = state.data;
                  is2FAIcon = state.data
                      ? 'assets/eva_icons/outline/svg/shield-outline.svg'
                      : 'assets/eva_icons/outline/svg/shield-off-outline.svg';
                }
              },
              child: BlocBuilder<TwoFactorAuthenticationBloc, CommonState>(
                builder: (BuildContext context, CommonState state) {
                  return Column(children: [
                    SwitchListTile(
                      secondary: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: SvgPicture.asset(is2FAIcon)),
                      title: Text(
                        DongkapLocalizations.of(context)
                            .twoFactorAuthentication,
                        style: const TextStyle(fontFamily: AppTheme.fontName),
                      ),
                      subtitle: Text(
                        DongkapLocalizations.of(context)
                            .twoFactorAuthenticationSubtitle,
                        style: const TextStyle(fontFamily: AppTheme.fontName),
                      ),
                      contentPadding:
                          const EdgeInsets.only(left: 5.0, right: 15.0),
                      value: is2FA,
                      activeColor: AppTheme.colorTheme,
                      onChanged: (bool value) {
                        _prompt2FA(context, value);
                      },
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1.0,
                      indent: 60,
                    ),
                  ]);
                },
              ),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
                'assets/eva_icons/outline/svg/slash-outline.svg'),
            title: Text(
              DongkapLocalizations.of(context).deactivateAccount,
              style: const TextStyle(fontFamily: AppTheme.fontName),
            ),
            horizontalTitleGap: 2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            trailing: SvgPicture.asset(
                'assets/eva_icons/outline/svg/arrow-ios-forward-outline.svg'),
            onTap: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => DeactivateAccountPage(
                        animationController: widget.animationController)),
              );
            },
          ),
          const Divider(
            height: 1,
            thickness: 1.0,
            indent: 60,
          ),
        ],
      ),
    );
  }

  void _prompt2FA(BuildContext context, bool twoFA) async {
    String subtitle = DongkapLocalizations.of(context)
        .promptTwoFactorAuthenticationDisableSubtitle;
    if (twoFA)
      subtitle = DongkapLocalizations.of(context)
          .promptTwoFactorAuthenticationEnableSubtitle;
    await showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: false,
        isDismissible: false,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return DialogBottomSheet(
            title: DongkapLocalizations.of(context)
                .promptTwoFactorAuthenticationTitle,
            subtitle: subtitle,
            submit: DongkapLocalizations.of(context).buttonSubmit,
            onSubmit: () {
              Navigator.of(context, rootNavigator: true).pop();
              context
                  .read<TwoFactorAuthenticationBloc>()
                  .add(SubmittedEvent<bool>(data: twoFA));
            },
          );
        });
  }

  void _loading(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0)),
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
