import 'package:equatable/equatable.dart';

abstract class CommonEvent extends Equatable {
  const CommonEvent();

  @override
  List<Object> get props => [];
}

class RequestedEvent extends CommonEvent {
  const RequestedEvent();
}

class SubmittedEvent extends CommonEvent {
  const SubmittedEvent();
}
