import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({@required AuthService authService})
      : assert(authService != null),
        _authService = authService,
        super(ProfileLoading());

  final AuthService _authService;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileFetched) {
      yield ProfileLoading();
      try {
        ProfileService profileService =
            ProfileService(authService: _authService);
        ProfileDto profile = await profileService.getProfile();
        yield ProfileSuccess(profile: profile);
      } catch (e) {
        yield ProfileError(error: e.toString());
      }
    }
  }
}
