import 'package:camera/camera.dart';
import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_dart/keys/camera_keys.dart';
import 'package:do_dart/widgets/error_camera_widget.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  final globalKey = GlobalKey<ScaffoldState>();

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
  Widget build(BuildContext context) => BlocConsumer<CameraBloc, CameraState>(
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
      builder: (_, state) => Scaffold(
            key: globalKey,
            backgroundColor: Colors.black,
            appBar: AppBar(title: const Text('Camera')),
            body: state is CameraReady
                ? Container(
                    key: CameraKeys.cameraPreviewScreen,
                    child: CameraPreview(
                        BlocProvider.of<CameraBloc>(context).getController()))
                : state is CameraFailure
                    ? ErrorCameraWidget(
                        key: CameraKeys.errorCameraScreen, message: state.error)
                    : Container(
                        key: CameraKeys.emptyContainerScreen,
                      ),
            floatingActionButton: state is CameraReady
                ? FloatingActionButton(
                    child: const Icon(Icons.camera_alt),
                    onPressed: () => BlocProvider.of<CameraBloc>(context)
                        .add(const CameraCapturedEvent()),
                  )
                : Container(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ));
}
