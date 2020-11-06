import 'environment.dart';

class EnviromentProduction extends Enviroment {
  Map<String, dynamic> get config =>
      {'profile': 'PROD', 'locale': 'en-US', 'debug': false};

  Map<String, dynamic> get hosts => {
        'hosts': {
          'openapi': {
            'host': 'https://dongkap-api.herokuapp.com',
          },
          'auth': {
            'host': 'https://dongkap-api.herokuapp.com',
          },
          'security': {
            'host': 'https://dongkap-api.herokuapp.com',
          },
          'profile': {
            'host': 'https://dongkap-api.herokuapp.com',
          },
          'master': {
            'host': 'https://dongkap-api.herokuapp.com',
          },
          'file': {
            'host': 'https://dongkap-api.herokuapp.com',
          },
          'notification': {
            'host': 'https://dongkap-api.herokuapp.com',
          }
        },
      };
}
