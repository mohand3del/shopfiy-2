/// Matches [LoginResponse] from the OpenAPI schema (`accessories-eshop.runasp.net`).
class LoginResponseModel {
  final String accessToken;
  final String refreshToken;
  final String expiresAtUtc;

  const LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAtUtc,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: (json['accessToken'] ?? json['access_token'] ?? '').toString(),
      refreshToken: (json['refreshToken'] ?? json['refresh_token'] ?? '').toString(),
      expiresAtUtc: (json['expiresAtUtc'] ?? json['expires_at_utc'] ?? '').toString(),
    );
  }
}
