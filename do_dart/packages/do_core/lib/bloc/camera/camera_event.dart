part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

class CameraInitializedEvent extends CameraEvent {
  const CameraInitializedEvent();
}

class CameraStoppedEvent extends CameraEvent {
  const CameraStoppedEvent();
}

class CameraCapturedEvent extends CameraEvent {
  const CameraCapturedEvent();
}
