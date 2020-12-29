import 'package:bloc/bloc.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:meta/meta.dart';

class PhotoProfileBloc extends Bloc<CommonEvent, CommonState> {
  PhotoProfileBloc({@required AuthService authService})
      : assert(authService != null),
        _authService = authService,
        super(RequestInProgressState());

  final AuthService _authService;
  ProfileService profileService;

  @override
  Stream<CommonState> mapEventToState(CommonEvent event) async* {
    if (event is RequestedEvent) {
      yield RequestInProgressState();
      try {
        String data = await getPhoto();
        yield RequestSuccessState<String>(data: data);
      } on ServerError catch (e) {
        yield RequestFailureState(error: e.getErrorMessage());
      }
    }
  }

  Future<String> getPhoto() async {
    profileService = ProfileService(authService: _authService);
    String photo = await profileService.getPhotoProfile();
    return photo;
  }
}
