class AuthService {

  String accessToken =
      "expired_token";

  String refreshToken =
      "refresh_token";

  /// Simulated refresh API
  Future<String>
  refreshAccessToken() async {

    await Future.delayed(
      const Duration(seconds: 2),
    );

    accessToken =
    "new_access_token";

    return accessToken;
  }
}