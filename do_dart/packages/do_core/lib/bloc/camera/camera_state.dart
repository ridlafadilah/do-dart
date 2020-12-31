part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraReady extends CameraState {}

class CameraCaptureInProgress extends CameraState {}

class CameraCaptureSuccess extends CameraState {
  const CameraCaptureSuccess({this.path});

  final String path;

  @override
  List<String> get props => [path];
}

class CameraFailure extends CameraState {
  const CameraFailure({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Camera Failure { error: $error }';
}

class CameraCaptureFailure extends CameraState {
  const CameraCaptureFailure({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Camera Capture Failure { error: $error }';
}
