part of 'provider_bloc.dart';

class LocalState extends CommonState {}

class SocialState extends CommonState {
  const SocialState({this.provider});

  final String provider;

  @override
  List<String> get props => [provider];
}
