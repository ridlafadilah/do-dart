import 'dart:async';

import 'package:dio/dio.dart';
import 'package:do_core/api/profile/profile_api.dart';
import 'package:do_core/exceptions/server_error_exception.dart';
import 'package:do_core/models/profile_dto.dart';
import 'package:do_core/services/auth_service.dart';
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
          throw error;
          break;
        default:
      }
    });
    return response;
  }
}
