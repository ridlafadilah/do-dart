part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  const ProfileSuccess({this.profile});

  final ProfileDto profile;

  @override
  List<Object> get props => [profile];
}

class ProfileError extends ProfileState {
  const ProfileError({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'API Profile Failure { error: $error }';
}
