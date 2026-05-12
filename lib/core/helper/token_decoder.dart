import 'package:jwt_decoder/jwt_decoder.dart';

/// A service responsible only for decoding JWT tokens.
/// Single Responsibility: This class only handles token decoding.
class TokenDecoder {
  /// Decodes a JWT token and returns its claims as a Map.
  ///
  /// Throws [FormatException] if the token is invalid.
  Map<String, dynamic> decodeToken(String token) {
    try {
      return JwtDecoder.decode(token);
    } catch (e) {
      throw FormatException('Invalid JWT token: $e');
    }
  }

  /// Checks if the token is expired.
  bool isTokenExpired(String token) {
    try {
      return JwtDecoder.isExpired(token);
    } catch (e) {
      throw FormatException('Invalid JWT token: $e');
    }
  }

  /// Returns the remaining time until expiration.
  Duration getTokenRemainingTime(String token) {
    try {
      return JwtDecoder.getRemainingTime(token);
    } catch (e) {
      throw FormatException('Invalid JWT token: $e');
    }
  }
}
