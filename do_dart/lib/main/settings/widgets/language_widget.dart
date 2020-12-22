import 'package:do_common/common.dart';
import 'package:do_core/models.dart';
import 'package:flutter/material.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key key, @required this.locales, this.onSelect})
      : super(key: key);

  final List<LocaleDto> locales;
  final void Function(LocaleDto data) onSelect;

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
                  ),
                  subtitle: Text(
                    locales[index].subIdentifier,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  trailing: locales[index].localeUsed
                      ? SvgPicture.asset(
                          'assets/eva_icons/outline/svg/checkmark-outline.svg',
                          color: Theme.of(context).iconTheme.color,
                        )
                      : null,
                  onTap: locales[index].localeUsed
                      ? null
                      : () {
                          _promptLanguage(context, locales[index]);
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

  void _promptLanguage(BuildContext context, LocaleDto locale) async {
    await showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: false,
        isDismissible: false,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return DialogBottomSheet(
            title: DongkapLocalizations.of(context).promptLanguageTitle,
            subtitle: DongkapLocalizations.of(context)
                .promptLanguageSubtitle(locale.identifier),
            submit: DongkapLocalizations.of(context).buttonSubmit,
            onSubmit: () {
              Navigator.of(context, rootNavigator: true).pop();
              onSelect(locale);
            },
          );
        });
  }
}
