import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:do_core/api/profile/profile_api.dart';
import 'package:do_core/exceptions/server_error_exception.dart';
import 'package:do_core/models/base_response.dart';
import 'package:do_core/models/profile_dto.dart';
import 'package:do_core/services/auth_service.dart';
import 'package:do_core/services/core_locator.dart';
import 'package:do_core/services/shared_preferences_service.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:retrofit/retrofit.dart';
import 'package:path_provider/path_provider.dart';

class ProfileService {
  ProfileService({@required AuthService authService})
      : assert(authService != null),
        _authService = authService;

  final String pathImage = '/Images/profile';
  final logger = Logger();
  final AuthService _authService;
  final SharedPreferencesService _sharedPreferences =
      coreLocator<SharedPreferencesService>();
  ProfileAPI _profileAPI;

  Future<ProfileDto> getProfile() async {
    _profileAPI = ProfileAPI(Dio(), _authService);
    final ProfileDto response =
        await _profileAPI.getProfile().catchError((Object obj) {
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

  Future<BaseResponse> putProfile(ProfileDto profile) async {
    _profileAPI = ProfileAPI(Dio(), _authService);
    final BaseResponse response =
        await _profileAPI.putProfile(profile).catchError((Object obj) {
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

  Future<String> getPhotoProfile() async {
    final String imageUUID = _sharedPreferences.getString('image');
    final Directory srcDir = await getApplicationSupportDirectory();
    final Directory dirProfile = Directory('${srcDir.path}$pathImage');
    final File image = File('${dirProfile.path}/$imageUUID');
    if (imageUUID == null) {
      return null;
    }
    if (!await dirProfile.exists()) {
      await dirProfile.create(recursive: true);
    }
    if (image.existsSync()) {
      return '${dirProfile.path}/$imageUUID';
    } else {
      final Dio _dio = Dio();
      _dio.options.responseType = ResponseType.bytes;
      _profileAPI = ProfileAPI(_dio, _authService);
      final HttpResponse response =
          await _profileAPI.getPhotoProfile(imageUUID).catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            final error = ServerError.withError(error: obj as DioError);
            throw error;
            break;
          default:
        }
      });
      await image.writeAsBytes(response.data);
      return '${dirProfile.path}/$imageUUID';
    }
  }
}
