import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:do_core/utils/camera_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc({
    @required this.cameraUtils,
    this.resolutionPreset = ResolutionPreset.high,
    this.cameraLensDirection = CameraLensDirection.front,
  }) : super(CameraInitial());

  final CameraUtils cameraUtils;
  final ResolutionPreset resolutionPreset;
  final CameraLensDirection cameraLensDirection;

  CameraController _controller;
  CameraController getController() => _controller;

  bool isInitialized() => _controller.value.isInitialized ?? false;

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is CameraInitializedEvent) {
      yield* _mapCameraInitializedToState(event);
    } else if (event is CameraCapturedEvent) {
      yield* _mapCameraCapturedToState(event);
    } else if (event is CameraStoppedEvent) {
      yield* _mapCameraStoppedToState(event);
    }
  }

  Stream<CameraState> _mapCameraInitializedToState(
      CameraInitializedEvent event) async* {
    try {
      _controller = await cameraUtils.getCameraController(
          resolutionPreset, cameraLensDirection);
      await _controller.initialize();
      yield CameraReady();
    } on CameraException catch (error) {
      await _controller?.dispose();
      yield CameraFailure(error: error.description);
    } catch (error) {
      yield CameraFailure(error: error.toString());
    }
  }

  Stream<CameraState> _mapCameraCapturedToState(
      CameraCapturedEvent event) async* {
    if (state is CameraReady) {
      yield CameraCaptureInProgress();
      try {
        final path = await cameraUtils.getPath();
        await _controller.takePicture(path);
        yield CameraCaptureSuccess(path: path);
      } on CameraException catch (error) {
        yield CameraCaptureFailure(error: error.description);
      }
    }
  }

  Stream<CameraState> _mapCameraStoppedToState(
      CameraStoppedEvent event) async* {
    await _controller?.dispose();
    yield CameraInitial();
  }
}
