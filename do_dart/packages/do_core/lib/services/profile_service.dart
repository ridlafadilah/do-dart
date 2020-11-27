import 'dart:async';

import 'package:dio/dio.dart';
import 'package:do_core/core.dart';
import 'package:do_core/models/profile_dto.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

class ProfileService {
  ProfileService({@required AuthService authService})
      : assert(authService != null),
        _authService = authService;

  final logger = Logger();
  final AuthService _authService;

  Future<ProfileDto> getProfile() async {
    final _profileAPI = ProfileAPI(Dio(), _authService);
    final response = await _profileAPI.getProfile().catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final error = ServerError.withError(error: obj as DioError);
          logger.e(error.getErrorMessage());
          break;
        default:
      }
    });
    return response;
  }
}
