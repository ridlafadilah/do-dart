import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:meta/meta.dart';

class ProfileBloc extends CommonBloc<ProfileDto, Object, dynamic> {
  ProfileBloc({@required AuthService authService})
      : assert(authService != null),
        _authService = authService,
        super(RequestInProgressState());

  final AuthService _authService;

  @override
  Future<ProfileDto> getData() async {
    ProfileService profileService = ProfileService(authService: _authService);
    ProfileDto profile = await profileService.getProfile();
    return profile;
  }

  @override
  Future<dynamic> putData(Object data) => null;
}
