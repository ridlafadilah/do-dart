import 'package:equatable/equatable.dart';

abstract class CommonState extends Equatable {
  const CommonState();

  @override
  List<Object> get props => [];
}

class InitialState extends CommonState {}

class RequestInProgressState extends CommonState {}

class RequestSuccessState extends CommonState {
  const RequestSuccessState({this.data});

  final Object data;

  @override
  List<Object> get props => [data];
}

class RequestFailureState extends CommonState {
  const RequestFailureState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Request State Failure { error: $error }';
}

class SubmitInProgressState extends CommonState {}

class SubmitSuccessState extends CommonState {
  const SubmitSuccessState({this.data});

  final Object data;

  @override
  List<Object> get props => [data];
}

class SubmitFailureState extends CommonState {
  const SubmitFailureState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Request State Failure { error: $error }';
}
