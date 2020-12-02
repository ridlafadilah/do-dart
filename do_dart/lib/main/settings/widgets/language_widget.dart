import 'package:do_core/models.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({Key key, this.animationController, this.animation})
      : super(key: key);

  final AnimationController animationController;
  final Animation animation;

  @override
  _LanguageWidgetState createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  List<LocaleDto> locales = <LocaleDto>[];

  @override
  void initState() {
    locales = <LocaleDto>[
      LocaleDto.fromJson({
        'localeCode': 'en-US',
        'identifier': 'English (United States)',
        'icon': 'en',
        'localeDefault': true,
        'localeEnabled': true,
      }),
      LocaleDto.fromJson({
        'localeCode': 'id-ID',
        'identifier': 'Indonesian (Indonesia)"',
        'localeDefault': false,
        'localeEnabled': true,
      }),
      LocaleDto.fromJson({
        'localeCode': 'sms-FI',
        'identifier': 'Sami (Skolt) (Finland)',
        'localeDefault': false,
        'localeEnabled': true,
      }),
      LocaleDto.fromJson({
        'localeCode': 'hi-IN',
        'identifier': 'Hindi (India)',
        'localeDefault': false,
        'localeEnabled': true,
      }),
      LocaleDto.fromJson({
        'localeCode': 'es-CL',
        'identifier': 'Spanish (Chile)',
        'localeDefault': false,
        'localeEnabled': true,
      }),
      LocaleDto.fromJson({
        'localeCode': 'ar-BH',
        'identifier': 'Arabic (Bahrain)',
        'localeDefault': false,
        'localeEnabled': true,
      }),
      LocaleDto.fromJson({
        'localeCode': 'da-DK',
        'identifier': 'Danish (Denmark)',
        'localeDefault': false,
        'localeEnabled': true,
      }),
      LocaleDto.fromJson({
        'localeCode': 'ka-GE',
        'identifier': 'Georgian (Georgia)',
        'localeDefault': false,
        'localeEnabled': true,
      }),
      LocaleDto.fromJson({
        'localeCode': 'ms-MY',
        'identifier': 'Malay (Malaysia)',
        'localeDefault': false,
        'localeEnabled': true,
      }),
      LocaleDto.fromJson({
        'localeCode': 'af-ZA',
        'identifier': 'Afrikaans (South Africa)',
        'localeDefault': false,
        'localeEnabled': true,
      }),
      LocaleDto.fromJson({
        'localeCode': 'zh-TW',
        'identifier': 'Chinese (Taiwan)',
        'localeDefault': false,
        'localeEnabled': true,
      }),
      LocaleDto.fromJson({
        'localeCode': 'ja-JP',
        'identifier': 'Japanese (Japan)',
        'localeDefault': false,
        'localeEnabled': true,
      }),
      LocaleDto.fromJson({
        'localeCode': 'th-TH',
        'identifier': 'Thai (Thailand)',
        'localeDefault': false,
        'localeEnabled': true,
      }),
    ];
    super.initState();
  }

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
