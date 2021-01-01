import 'package:camera/camera.dart';
import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_dart/widgets/error_camera_widget.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CaptureProfilePage extends StatefulWidget {
  const CaptureProfilePage({Key key, this.animationController, this.profile})
      : super(key: key);

  final AnimationController animationController;
  final ProfileDto profile;

  @override
  _CaptureProfilePageState createState() => _CaptureProfilePageState();
}

class _CaptureProfilePageState extends State<CaptureProfilePage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<CameraBloc>(context);

    // App state changed before we got the chance to initialize.
    if (!bloc.isInitialized()) return;

    if (state == AppLifecycleState.inactive)
      bloc.add(const CameraStoppedEvent());
    else if (state == AppLifecycleState.resumed)
      bloc.add(const CameraInitializedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CameraBloc(cameraUtils: CameraUtils())
        ..add(const CameraInitializedEvent()),
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          appBar: appBar(context),
          body: Stack(
            children: <Widget>[
              mainView(),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget mainView() {
    return BlocConsumer<CameraBloc, CameraState>(
      listener: (_, state) {
        if (state is CameraCaptureSuccess)
          Navigator.of(context).pop(state.path);
        else if (state is CameraCaptureFailure) {
          Flushbar(
            messageText: Text(
              state.error,
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
      },
      builder: (_, state) => Container(
        child: state is CameraReady
            ? Container(
                key: const Key('__cameraPreviewScreen__'),
                child: CameraPreview(
                    BlocProvider.of<CameraBloc>(context).getController()))
            : state is CameraFailure
                ? ErrorCameraWidget(
                    key: const Key('__errorCameraScreen__'),
                    message: state.error)
                : Container(
                    key: const Key('__emptyContainerScreen__'),
                  ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return DongkapAppBar(
      animationController: widget.animationController,
      topBarOpacity: 0.0,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 40,
            width: 40,
            child: InkWell(
              highlightColor: AppTheme.darkBlueGrey.withOpacity(0.2),
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
              DongkapLocalizations.of(context).photoProfile,
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
}
