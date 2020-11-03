import 'environment.dart';

class EnviromentProduction extends Enviroment {
  String get profile => 'production';
  String get locale => 'en-US';
  Map<String, dynamic> get host => {
        'openapi': {
          'protocol': 'https',
          'host': 'dongkap-api.herokuapp.com',
        },
        'auth': {
          'protocol': 'https',
          'host': 'dongkap-api.herokuapp.com',
        },
        'security': {
          'protocol': 'https',
          'host': 'dongkap-api.herokuapp.com',
        },
        'profile': {
          'protocol': 'https',
          'host': 'dongkap-api.herokuapp.com',
        },
        'master': {
          'protocol': 'https',
          'host': 'dongkap-api.herokuapp.com',
        },
        'file': {
          'protocol': 'https',
          'host': 'dongkap-api.herokuapp.com',
        },
        'notification': {
          'protocol': 'https',
          'host': 'dongkap-api.herokuapp.com',
        }
      };
}
