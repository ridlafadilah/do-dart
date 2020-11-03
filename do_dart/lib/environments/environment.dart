class Enviroment {
  String get profile => 'development';
  String get locale => 'en-US';
  Map<String, dynamic> get host => {
        'openapi': {
          'protocol': 'http',
          'host': 'localhost',
          'port': 8085,
        },
        'auth': {
          'protocol': 'http',
          'host': 'localhost',
          'port': 8085,
        },
        'security': {
          'protocol': 'http',
          'host': 'localhost',
          'port': 8085,
        },
        'profile': {
          'protocol': 'http',
          'host': 'localhost',
          'port': 8085,
        },
        'master': {
          'protocol': 'http',
          'host': 'localhost',
          'port': 8085,
        },
        'file': {
          'protocol': 'http',
          'host': 'localhost',
          'port': 8085,
        },
        'notification': {
          'protocol': 'http',
          'host': 'localhost',
          'port': 8085,
        }
      };
}
