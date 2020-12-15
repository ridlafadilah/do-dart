// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class DongkapLocalizations {
  DongkapLocalizations();
  
  static DongkapLocalizations current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<DongkapLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      DongkapLocalizations.current = DongkapLocalizations();
      
      return DongkapLocalizations.current;
    });
  } 

  static DongkapLocalizations of(BuildContext context) {
    return Localizations.of<DongkapLocalizations>(context, DongkapLocalizations);
  }

  /// `Hello,`
  String get hello {
    return Intl.message(
      'Hello,',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message(
      'Security',
      name: 'security',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Default Mode`
  String get defaultMode {
    return Intl.message(
      'Default Mode',
      name: 'defaultMode',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Place / Date of Birth`
  String get pdob {
    return Intl.message(
      'Place / Date of Birth',
      name: 'pdob',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate Account`
  String get deactivateAccount {
    return Intl.message(
      'Deactivate Account',
      name: 'deactivateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Once you deactivated account, there is no going back. Please be certain.`
  String get deactivateAccountWarning {
    return Intl.message(
      'Once you deactivated account, there is no going back. Please be certain.',
      name: 'deactivateAccountWarning',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `2-Step Verification`
  String get twoFactorAuthentication {
    return Intl.message(
      '2-Step Verification',
      name: 'twoFactorAuthentication',
      desc: '',
      args: [],
    );
  }

  /// `Send a verification code every time you login`
  String get twoFactorAuthenticationSubtitle {
    return Intl.message(
      'Send a verification code every time you login',
      name: 'twoFactorAuthenticationSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `{value} Days`
  String days(Object value) {
    return Intl.message(
      '$value Days',
      name: 'days',
      desc: '',
      args: [value],
    );
  }

  /// `Exercise`
  String get exercise {
    return Intl.message(
      'Exercise',
      name: 'exercise',
      desc: '',
      args: [],
    );
  }

  /// `Template`
  String get template {
    return Intl.message(
      'Template',
      name: 'template',
      desc: '',
      args: [],
    );
  }

  /// `Username / Email`
  String get hintUsernameEmail {
    return Intl.message(
      'Username / Email',
      name: 'hintUsernameEmail',
      desc: '',
      args: [],
    );
  }

  /// `or enter with`
  String get labelFooterLoginSocial {
    return Intl.message(
      'or enter with',
      name: 'labelFooterLoginSocial',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get labelFooterLoginOther {
    return Intl.message(
      'Don\'t have an account?',
      name: 'labelFooterLoginOther',
      desc: '',
      args: [],
    );
  }

  /// `Hello! Login with your username or email.`
  String get labelLogin {
    return Intl.message(
      'Hello! Login with your username or email.',
      name: 'labelLogin',
      desc: '',
      args: [],
    );
  }

  /// `Username or email :`
  String get labelUsernameEmail {
    return Intl.message(
      'Username or email :',
      name: 'labelUsernameEmail',
      desc: '',
      args: [],
    );
  }

  /// `Logged in with {value}?`
  String labelLoginSocial(Object value) {
    return Intl.message(
      'Logged in with $value?',
      name: 'labelLoginSocial',
      desc: '',
      args: [value],
    );
  }

  /// `Username is required!`
  String get errorUsername {
    return Intl.message(
      'Username is required!',
      name: 'errorUsername',
      desc: '',
      args: [],
    );
  }

  /// `Password is required!`
  String get errorPassword {
    return Intl.message(
      'Password is required!',
      name: 'errorPassword',
      desc: '',
      args: [],
    );
  }

  /// `Make sure it's at least 8 characters\nincluding a number, a lowercase, and uppercase letter`
  String get errorNewPassword {
    return Intl.message(
      'Make sure it\'s at least 8 characters\nincluding a number, a lowercase, and uppercase letter',
      name: 'errorNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password and Confirm Password not match`
  String get errorConfirmPassword {
    return Intl.message(
      'New Password and Confirm Password not match',
      name: 'errorConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Next workout`
  String get badgeExerciseTitle {
    return Intl.message(
      'Next workout',
      name: 'badgeExerciseTitle',
      desc: '',
      args: [],
    );
  }

  /// `UI Widgets (Components)\nAPI calls\nAccessibility & i18n`
  String get badgeExerciseSubtitle {
    return Intl.message(
      'UI Widgets (Components)\nAPI calls\nAccessibility & i18n',
      name: 'badgeExerciseSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Your Profile`
  String get titleWidgetProfiletitle {
    return Intl.message(
      'Your Profile',
      name: 'titleWidgetProfiletitle',
      desc: '',
      args: [],
    );
  }

  /// `Customize`
  String get titleWidgetProfileSubtitle {
    return Intl.message(
      'Customize',
      name: 'titleWidgetProfileSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `2-Step Verification`
  String get promptTwoFactorAuthenticationTitle {
    return Intl.message(
      '2-Step Verification',
      name: 'promptTwoFactorAuthenticationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to enable 2-Step Verification?`
  String get promptTwoFactorAuthenticationEnableSubtitle {
    return Intl.message(
      'Are you sure want to enable 2-Step Verification?',
      name: 'promptTwoFactorAuthenticationEnableSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to disable 2-Step Verification?`
  String get promptTwoFactorAuthenticationDisableSubtitle {
    return Intl.message(
      'Are you sure want to disable 2-Step Verification?',
      name: 'promptTwoFactorAuthenticationDisableSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate Account`
  String get promptDeactivateAccountTitle {
    return Intl.message(
      'Deactivate Account',
      name: 'promptDeactivateAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone. This will permanently disable your account.\nI understand the consequences`
  String get promptDeactivateAccountSubtitle {
    return Intl.message(
      'This action cannot be undone. This will permanently disable your account.\nI understand the consequences',
      name: 'promptDeactivateAccountSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Change Theme`
  String get promptThemeTitle {
    return Intl.message(
      'Change Theme',
      name: 'promptThemeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to change to {value}?`
  String promptThemeSubtitle(Object value) {
    return Intl.message(
      'Are you sure want to change to $value?',
      name: 'promptThemeSubtitle',
      desc: '',
      args: [value],
    );
  }

  /// `Change Language`
  String get promptLanguageTitle {
    return Intl.message(
      'Change Language',
      name: 'promptLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to change the language into {value}?`
  String promptLanguageSubtitle(Object value) {
    return Intl.message(
      'Are you sure want to change the language into $value?',
      name: 'promptLanguageSubtitle',
      desc: '',
      args: [value],
    );
  }

  /// `Submit`
  String get buttonSubmit {
    return Intl.message(
      'Submit',
      name: 'buttonSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get buttonCancel {
    return Intl.message(
      'Cancel',
      name: 'buttonCancel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<DongkapLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'id'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<DongkapLocalizations> load(Locale locale) => DongkapLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}