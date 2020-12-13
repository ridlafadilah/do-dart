import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'provider_event.dart';
part 'provider_state.dart';

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
