import 'package:equatable/equatable.dart';

abstract class CommonState extends Equatable {
  const CommonState();

  @override
  List<Object> get props => [];
}

class InProgressState extends CommonState {}

class SuccessState<T> extends CommonState {
  const SuccessState({this.data});

  final T data;

  @override
  List<Object> get props => [data];
}

class FailureState extends CommonState {
  const FailureState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'State Failure { error: $error }';
}
