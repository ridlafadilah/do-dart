import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_dart/main/security/bloc/provider_event.dart';
import 'package:do_dart/main/security/bloc/provider_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderBloc extends Bloc<ProviderEvent, CommonState> {
  ProviderBloc() : super(LocalState());

  @override
  Stream<CommonState> mapEventToState(ProviderEvent event) async* {
    ProviderService providerService = ProviderService();
    final String provider = providerService.getData();
    switch (provider) {
      case ProviderType.local:
        yield LocalState();
        break;
      default:
        yield SocialState(provider: provider);
    }
  }
}
