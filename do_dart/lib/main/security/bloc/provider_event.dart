part of 'provider_bloc.dart';

class ProviderType {
  static const String local = 'local';
  static const String google = 'google';
}

class ProviderEvent extends CommonEvent {
  const ProviderEvent();
}
