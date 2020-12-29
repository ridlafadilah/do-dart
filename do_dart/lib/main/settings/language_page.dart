import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_core/models/locale_dto.dart';
import 'package:do_dart/l10n/bloc/translation_bloc.dart';
import 'package:do_dart/l10n/utils/locale_utils.dart';
import 'package:do_dart/main/settings/bloc/language_bloc.dart';
import 'package:do_dart/main/settings/widgets/language_widget.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage>
    with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];
  final ScrollController _scrollController = ScrollController();
  double _topBarOpacity = 0.0;
  List<LocaleDto> data = <LocaleDto>[];

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset >= 24) {
        if (_topBarOpacity != 1.0) {
          setState(() {
            _topBarOpacity = 1.0;
          });
        }
      } else if (_scrollController.offset <= 24 &&
          _scrollController.offset >= 0) {
        if (_topBarOpacity != _scrollController.offset / 24) {
          setState(() {
            _topBarOpacity = _scrollController.offset / 24;
          });
        }
      } else if (_scrollController.offset <= 0) {
        if (_topBarOpacity != 0.0) {
          setState(() {
            _topBarOpacity = 0.0;
          });
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: appBar(),
        body: Stack(
          children: <Widget>[
            mainView(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget mainView() {
    return BlocProvider(
      create: (context) {
        return LanguageBloc(
          authService: RepositoryProvider.of<AuthService>(context),
        )..add(const RequestedEvent());
      },
      child: BlocListener<LanguageBloc, CommonState>(
        listener: (context, state) {
          if (state is RequestSuccessState<List<LocaleDto>>) {
            data = state.data;
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
                'AppTheme.lightColor',
                color: Theme.of(context).iconTheme.color,
              ),
              duration: const Duration(seconds: 3),
              backgroundColor: AppTheme.lightDanger,
              isDismissible: false,
              dismissDirection: FlushbarDismissDirection.VERTICAL,
            )..show(context);
          } else if (state is SubmitSuccessState<BaseResponse>) {
            context.read<TranslationBloc>().add(const TranslationEvent());
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<LanguageBloc, CommonState>(
          builder: (BuildContext context, CommonState state) {
            return ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.only(
                bottom: 62 + MediaQuery.of(context).padding.bottom,
              ),
              itemCount: 1,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return LanguageWidget(
                  locales: data,
                  onSelect: (LocaleDto localeDto) {
                    context
                        .read<LanguageBloc>()
                        .add(SubmittedEvent<LocaleDto>(data: localeDto));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget appBar() {
    return DongkapAppBar(
      animationController: widget.animationController,
      topBarOpacity: _topBarOpacity,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 40,
            width: 40,
            child: InkWell(
              highlightColor: AppTheme.darkGrey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              onTap: () {
                Navigator.of(context).pop(true);
              },
              child: Center(
                child: SvgPicture.asset(
                  'assets/eva_icons/outline/svg/arrow-back-outline.svg',
                  color: Theme.of(context).appBarTheme.iconTheme.color,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DongkapLocalizations.of(context).language,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 22 + 6 - 6 * 0.0,
                color: Theme.of(context).appBarTheme.titleTextStyle.color,
                fontFamily:
                    Theme.of(context).appBarTheme.titleTextStyle.fontFamily,
                fontWeight:
                    Theme.of(context).appBarTheme.titleTextStyle.fontWeight,
                letterSpacing:
                    Theme.of(context).appBarTheme.titleTextStyle.letterSpacing,
              ),
            ),
          ),
        ),
      ],
    );
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
