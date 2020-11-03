import 'package:json_annotation/json_annotation.dart';

part 'oauth_result.g.dart';

@JsonSerializable()
class OAuthResult {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'token_type')
  String tokenType;
  @JsonKey(name: 'xrkey')
  String publicKey;
  @JsonKey(name: 'expires_in')
  int expiresIn;
  String authority;
  String provider;
  String image;
  String email;
  String menus;
  String extras;
  @JsonKey(name: 'server_date')
  String serverDate;
  String locale;
  String theme;
  String name;

  OAuthResult(
      this.accessToken,
      this.refreshToken,
      this.tokenType,
      this.publicKey,
      this.expiresIn,
      this.authority,
      this.provider,
      this.image,
      this.email,
      this.menus,
      this.extras,
      this.serverDate,
      this.locale,
      this.theme,
      this.name);

  factory OAuthResult.fromJson(Map<String, dynamic> json) =>
      _$OAuthResultFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthResultToJson(this);

  @override
  String toString() {
    return 'OAuthResult{' +
        'accessToken: $accessToken, ' +
        'refreshToken: $refreshToken, ' +
        'tokenType: $tokenType, ' +
        'publicKey: $publicKey, ' +
        'expiresIn: $expiresIn, ' +
        'authority: $authority, ' +
        'provider: $provider, ' +
        'image: $image, ' +
        'email: $email, ' +
        'menus: $menus, ' +
        'extras: $extras, ' +
        'serverDate: $serverDate, ' +
        'locale: $locale, ' +
        'theme: $theme, ' +
        'name: $name}';
  }
}
