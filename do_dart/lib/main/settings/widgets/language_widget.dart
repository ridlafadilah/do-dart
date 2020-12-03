import 'package:do_core/models.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({Key key}) : super(key: key);

  @override
  _LanguageWidgetState createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  final List<LocaleDto> locales = <LocaleDto>[
    LocaleDto.fromJson({
      'localeCode': 'en-US',
      'identifier': 'English',
      'subIdentifier': 'United States',
      'icon': 'flag-icon flag-icon-us',
      'localeDefault': true,
      'localeEnabled': true,
    }),
    LocaleDto.fromJson({
      'localeCode': 'id-ID',
      'identifier': 'Indonesian',
      'subIdentifier': 'Indonesia',
      'icon': 'flag-icon flag-icon-id',
      'localeDefault': false,
      'localeEnabled': true,
    }),
  ];

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
                  onTap: () {},
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
}
