import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_dart/main/settings/bloc/theme_bloc.dart';
import 'package:do_dart/main/settings/language_page.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  bool isDarkMode = false;
  String iconDarkMode = 'assets/eva_icons/fill/svg/moon.svg';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            leading: SvgPicture.asset(
                'assets/eva_icons/outline/svg/globe-outline.svg'),
            title: Text(
              AppLocalizations.of(context).language,
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
                    builder: (BuildContext context) => LanguagePage(
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
              return ThemeBloc(
                authService: RepositoryProvider.of<AuthService>(context),
              )..add(const RequestedEvent());
            },
            child: BlocListener<ThemeBloc, CommonState>(
              listener: (context, state) {
                if (state is RequestSuccessState<bool>) {
                  isDarkMode = state.data;
                  iconDarkMode = state.data
                      ? 'assets/eva_icons/outline/svg/moon-outline.svg'
                      : 'assets/eva_icons/fill/svg/moon.svg';
                }
                if (state is SubmitInProgressState) {
                  _loading(context);
                } else if (state is SubmitFailureState) {
                  Navigator.of(context, rootNavigator: true).pop();
                } else if (state is SubmitSuccessState<bool>) {
                  Navigator.of(context, rootNavigator: true).pop();
                  isDarkMode = state.data;
                  iconDarkMode = state.data
                      ? 'assets/eva_icons/outline/svg/moon-outline.svg'
                      : 'assets/eva_icons/fill/svg/moon.svg';
                }
              },
              child: BlocBuilder<ThemeBloc, CommonState>(
                builder: (BuildContext context, CommonState state) {
                  return Column(children: [
                    SwitchListTile(
                      secondary: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: SvgPicture.asset(iconDarkMode)),
                      title: Text(
                        AppLocalizations.of(context).darkMode,
                        style: const TextStyle(fontFamily: AppTheme.fontName),
                      ),
                      contentPadding:
                          const EdgeInsets.only(left: 5.0, right: 15.0),
                      value: isDarkMode,
                      activeColor: AppTheme.colorTheme,
                      onChanged: (bool value) {
                        _promptTheme(context, value);
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
        ],
      ),
    );
  }

  void _promptTheme(BuildContext context, bool darkMode) async {
    String subtitle = AppLocalizations.of(context).defaultMode;
    if (darkMode) subtitle = AppLocalizations.of(context).darkMode;
    subtitle = AppLocalizations.of(context).promptThemeSubtitle(subtitle);
    await showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: false,
        isDismissible: false,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return DialogBottomSheet(
            title: AppLocalizations.of(context).promptThemeTitle,
            subtitle: subtitle,
            submit: AppLocalizations.of(context).buttonSubmit,
            height: 260.0,
            onSubmit: () {
              Navigator.of(context, rootNavigator: true).pop();
              context
                  .read<ThemeBloc>()
                  .add(SubmittedEvent<bool>(data: darkMode));
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
