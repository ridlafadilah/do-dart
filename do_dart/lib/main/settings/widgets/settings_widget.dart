import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_dart/l10n/utils/locale_utils.dart';
import 'package:do_dart/main/settings/bloc/theme_bloc.dart';
import 'package:do_dart/main/settings/language_page.dart';
import 'package:do_dart/theme/bloc/thememode_bloc.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:do_dart/generated/l10n.dart';
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
              'assets/eva_icons/outline/svg/globe-outline.svg',
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              DongkapLocalizations.of(context).language,
            ),
            horizontalTitleGap: 2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            trailing: SvgPicture.asset(
              'assets/eva_icons/outline/svg/arrow-ios-forward-outline.svg',
              color: Theme.of(context).iconTheme.color,
            ),
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
                      ? 'assets/eva_icons/fill/svg/moon.svg'
                      : 'assets/eva_icons/outline/svg/moon-outline.svg';
                }
                if (state is SubmitInProgressState) {
                  _loading(context);
                } else if (state is SubmitFailureState) {
                  Navigator.of(context, rootNavigator: true).pop();
                  Flushbar(
                    messageText: Text(
                      LocaleUtils.translate(LocaleUtils.translate(state.error)),
                      style: const TextStyle(color: Colors.white),
                    ),
                    icon: SvgPicture.asset(
                      'assets/eva_icons/outline/svg/alert-triangle-outline.svg',
                      color: AppTheme.lightColor,
                    ),
                    duration: const Duration(seconds: 3),
                    backgroundColor: AppTheme.lightDanger,
                    isDismissible: false,
                    dismissDirection: FlushbarDismissDirection.VERTICAL,
                  )..show(context);
                } else if (state is SubmitSuccessState<bool>) {
                  context.read<ThemeModeBloc>().add(const ThemeModeEvent());
                  Navigator.of(context, rootNavigator: true).pop();
                  isDarkMode = state.data;
                  iconDarkMode = state.data
                      ? 'assets/eva_icons/fill/svg/moon.svg'
                      : 'assets/eva_icons/outline/svg/moon-outline.svg';
                }
              },
              child: BlocBuilder<ThemeBloc, CommonState>(
                builder: (BuildContext context, CommonState state) {
                  return Column(children: [
                    SwitchListTile(
                      secondary: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: SvgPicture.asset(
                            iconDarkMode,
                            color: Theme.of(context).iconTheme.color,
                          )),
                      title: Text(
                        DongkapLocalizations.of(context).darkMode,
                      ),
                      contentPadding:
                          const EdgeInsets.only(left: 5.0, right: 15.0),
                      value: isDarkMode,
                      activeColor:
                          Theme.of(context).toggleButtonsTheme.selectedColor,
                      onChanged: (bool value) {
                        _promptTheme(context, value);
                      },
                    ),
                    const Divider(
                      height: 1,
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
    String subtitle = DongkapLocalizations.of(context).defaultMode;
    if (darkMode) subtitle = DongkapLocalizations.of(context).darkMode;
    subtitle = DongkapLocalizations.of(context).promptThemeSubtitle(subtitle);
    await showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: false,
        isDismissible: false,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return DialogBottomSheet(
            title: DongkapLocalizations.of(context).promptThemeTitle,
            subtitle: subtitle,
            submit: DongkapLocalizations.of(context).buttonSubmit,
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
