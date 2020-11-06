class Enviroment {
  Map<String, dynamic> get config =>
      {'profile': 'DEV', 'locale': 'en-US', 'debug': true};

  Map<String, dynamic> get hosts => {
        'hosts': {
          'openapi': {
            'host': 'http://localhost:8085',
          },
          'auth': {
            'host': 'http://localhost:8085',
          },
          'security': {
            'host': 'http://localhost:8085',
          },
          'profile': {
            'host': 'http://localhost:8085',
          },
          'master': {
            'host': 'http://localhost:8085',
          },
          'file': {
            'host': 'http://localhost:8085',
          },
          'notification': {
            'host': 'http://localhost:8085',
          }
        }
      };
}
