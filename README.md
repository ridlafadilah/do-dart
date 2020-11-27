# do-dart [![Actions Status](https://github.com/ridlafadilah/do-dart/workflows/Dongkap%20Analyzer/badge.svg)](https://github.com/ridlafadilah/do-dart/actions)
Dongkap | Mobile Application with Flutter

```

   __| |   ___    _ __     __ _  | | __   __ _   _ __  
  / _` |  / _ \  | '_ \   / _` | | |/ /  / _` | | '_ \ 
 | (_| | | (_) | | | | | | (_| | |   <  | (_| | | |_) |
  \__,_|  \___/  |_| |_|  \__, | |_|\_\  \__,_| | .__/ 
                          |___/                 |_|    

```

## Features
* __Theme__
  * Main template using [Best-Flutter-UI-Templates](https://github.com/mitesh77/Best-Flutter-UI-Templates)

* __Integrate with API__
  * OAuth2 ( _soon_ )
  * JWT ( _soon_ )
  * Interceptor Header Signature (Hmac SHA-256) ( _soon_ )
  * Interceptor Header Accept-Language ( _soon_ )

* __Social Sign On__
  * Google ( _soon_ )

* __Google reCAPTCHA v2__ ( _soon_ )

* __i18n__ ( _soon_ )

* __Simple UI Template__
  * Login ( _soon_ )
  * Registration ( _soon_ )
  * Forgot Password ( _soon_ )
  * Change Password ( _soon_ )
  * Update Profile ( _soon_ )
  * Upload Photo Profile ( _soon_ )
  * Change Language ( _soon_ )
  * Dark Mode ( _soon_ )


## Environment setup
Make sure following software is installed on your PC.
* [Flutter 1.22.3](https://github.com/flutter/flutter.git) or later
* [Android Studio](https://developer.android.com/studio)
* [Visual Studio Code](https://code.visualstudio.com/download)


## Compile & Test
* __Development__

  * Download Packages :
	```
	do_dart$ flutter pub get
	```
	Click __Get Packages__ located in right side of the action ribbon at the top of pubspec.yaml.

  * Generate Json Models :
	```
	do_dart$ flutter pub run build_runner build --delete-conflicting-outputs
	```
	```
	do_dart/packages/do_core$ flutter pub run build_runner build
	```

  * Restart the Dart Analysis Server (VS Code) :

  	`CTRL + Shift + P` , then search look for a command called `Dart: Restart Analysis Server`

  * Run Application :
	```
	do_dart$ flutter run
	```
	or press __F5__ in Visual Studio Code

* __API__
  
  Please testing with [Dongkap Java API](https://github.com/ridlafadilah/do-api)

  > :warning: _If you are using the Dongkap Develpoment API, sometimes the connection to the server may timeout._

## How can I support?
  * Star Dongkap GitHub repo :star:
  * Create pull requests, submit bugs, suggest new features
  * If this project help you reduce time to develop, you can give me a cup of coffee :smiley:
    
    [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](http://paypal.me/ridlafadilah)
	
	[![Buy Me A Coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/ridlafadilah)
