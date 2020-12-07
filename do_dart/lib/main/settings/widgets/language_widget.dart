import 'package:do_common/common.dart';
import 'package:do_core/bloc/common_event.dart';
import 'package:do_core/bloc/common_state.dart';
import 'package:do_core/models.dart';
import 'package:do_dart/main/settings/bloc/change_language_bloc.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key key, @required this.locales}) : super(key: key);

  final List<LocaleDto> locales;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: locales.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    locales[index].identifier,
                    style: const TextStyle(fontFamily: AppTheme.fontName),
                  ),
                  subtitle: Text(
                    locales[index].subIdentifier,
                    style: const TextStyle(fontFamily: AppTheme.fontName),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  trailing: locales[index].localeDefault
                      ? SvgPicture.asset(
                          'assets/eva_icons/outline/svg/checkmark-outline.svg')
                      : null,
                  onTap: () {
                    _promptLanguage(context, locales[index].identifier);
                  },
                ),
                const Divider(
                  height: 1,
                  thickness: 1.0,
                  indent: 20,
                ),
              ],
            );
          }),
    );
  }

  void _promptLanguage(BuildContext context, String language) async {
    await showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: false,
        isDismissible: false,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return DialogBottomSheet(
            title: 'Change Language',
            subtitle:
                'Are you sure want to change the language into $language?',
            submit: 'Submit',
            onSubmit: () {
              Navigator.of(context, rootNavigator: true).pop();
              _loading(context);
            },
          );
        });
  }

  void _loading(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) {
            return ChangeLanguageBloc()..add(const SubmittedEvent());
          },
          child: BlocBuilder<ChangeLanguageBloc, CommonState>(
            builder: (BuildContext context, CommonState state) {
              return Container(
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        );
      },
    );
  }
}
