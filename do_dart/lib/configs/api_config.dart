class APIConfig {
  Map<String, dynamic> get api => {
        'api': {
          'openapi': {
            'parameter': {
              'method': 'POST',
              'path': '/do/oa/master/vw/parameter-i18n/v.1',
            }
          },
          'auth': {
            'token': {
              'method': 'POST',
              'path': '/do/oauth/token',
            },
            'extract-token': {
              'method': 'POST',
              'path': '/do/oauth/extract-token',
            },
            'authorize': {
              'method': 'POST',
              'path': '/do/oauth2/authorize',
            },
            'signup': {
              'method': 'POST',
              'path': '/do/oauth/signup',
            },
            'request-forgot-password': {
              'method': 'POST',
              'path': '/do/oauth/request-forgot-password',
            },
            'forgot-password': {
              'method': 'POST',
              'path': '/do/oauth/forgot-password',
            },
            'check-user': {
              'method': 'POST',
              'path': '/do/oauth/check-user',
            },
          },
          'security': {
            'revoke': {
              'method': 'DELETE',
              'path': '/do/api/security/oauth/token/revoke',
            },
            'change-password': {
              'method': 'POST',
              'path': '/do/api/security/trx/post/change-password/v.1',
            },
            'deactivated': {
              'method': 'POST',
              'path': '/do/api/security/trx/post/deactivated/v.1',
            },
            'change-settings': {
              'method': 'PUT',
              'path': '/do/api/security/trx/put/settings/v.1',
            },
            'get-settings': {
              'method': 'GET',
              'path': '/do/api/security/vw/get/settings/v.1',
            },
            'get-menus': {
              'method': 'GET',
              'path': '/do/api/security/vw/get/menus/v.1',
            },
          },
          'profile': {
            'change-profile': {
              'method': 'POST',
              'path': '/do/api/profile/trx/post/profile/v.1',
            },
            'get-profile': {
              'method': 'GET',
              'path': '/do/api/profile/vw/get/profile/v.1',
            },
          },
          'master': {
            'select-country': {
              'method': 'POST',
              'path': '/do/api/master/vw/post/select/country/v.1',
            },
            'select-province': {
              'method': 'POST',
              'path': '/do/api/master/vw/post/select/province/v.1',
            },
            'select-city': {
              'method': 'POST',
              'path': '/do/api/master/vw/post/select/city/v.1',
            },
            'select-district': {
              'method': 'POST',
              'path': '/do/api/master/vw/post/select/district/v.1',
            },
            'select-subdistrict': {
              'method': 'POST',
              'path': '/do/api/master/vw/post/select/subdistrict/v.1',
            },
            'select-language': {
              'method': 'POST',
              'path': '/do/api/master/vw/post/select/language/v.1',
            },
            'select-all-locale': {
              'method': 'GET',
              'path': '/do/api/master/vw/get/select/all/locale/v.1',
            },
            'all-locale': {
              'method': 'GET',
              'path': '/do/api/master/vw/get/all/locale/v.1',
            },
            'select-parameter': {
              'method': 'POST',
              'path': '/do/api/master/vw/post/select/parameter-i18n/v.1',
            },
            'parameter': {
              'method': 'POST',
              'path': '/do/api/master/vw/post/parameter-i18n/v.1',
            },
            'all-parameter-i18n': {
              'method': 'POST',
              'path': '/do/api/master/vw/auth/all/parameter-i18n/v.1',
            },
          },
          'file': {
            'photo-profile': {
              'method': 'POST',
              'path': '/do/api/file/trx/auth/photo-profile/v.1',
            },
            'vw-photo-profile': {
              'method': 'GET',
              'path': '/do/api/file/vw/get/photo-profile/v.1',
            },
          },
          'notification': {
            'send-broadcast': {
              'method': 'POST',
              'path': '/do/api/notification/trx/post/broadcast/v.1',
            },
            'push-subscribe': {
              'method': 'POST',
              'path': '/do/api/notification/push/subscribe/v.1',
            },
          }
        }
      };
}
