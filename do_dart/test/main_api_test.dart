import 'dart:async';
import 'package:dio/dio.dart';
import 'package:do_core/models.dart';
import 'package:do_dart/configs/security_config.dart';
import 'package:logger/logger.dart';
import 'package:test/test.dart';

import 'auth_api_test.dart';
import 'profile_api_test.dart';

final dio = Dio();
final logger = Logger();
OAuthResult oAuthResult;
AuthAPITest _authAPI;
ProfileAPITest _profileAPITest;

void main() {
  setUp(() async {
    _authAPI = AuthAPITest(Dio());
  });

  group('API', () {
    test('Login', () async {
      final String clientId =
          SecurityConfig().securityResourceModel['client_id'].toString();
      Map<String, dynamic> body = {
        'grant_type': 'password',
        'client_id': clientId,
        'username': 'male',
        'password': 'user123'
      };
      oAuthResult = await _authAPI.token(body);
      logger.i(oAuthResult.toString());
    });

    test('Get Profile', () async {
      _profileAPITest = ProfileAPITest(Dio(), oAuthResult);
      await _profileAPITest.getProfile().then((value) {
        logger.i(value.gender);
        logger.i(value.genderCode);
      });
    });

    test('Waiting', () async {
      logger.w('Waiting 15 seconds for the access_token to expired');
      await Future.delayed(const Duration(seconds: 15));
    });

    test('Refresh Token', () async {
      _profileAPITest = ProfileAPITest(Dio(), oAuthResult);
      await _profileAPITest.getProfile().then((value) {
        logger.i(value.gender);
        logger.i(value.genderCode);
      });
    }, timeout: const Timeout(Duration(seconds: 45)));
  }, timeout: const Timeout(Duration(minutes: 2)));
}
