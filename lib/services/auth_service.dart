import 'package:local_auth/local_auth.dart';

class AuthService {
  final auth = LocalAuthentication();
  String accessToken = "expired_token";

  String refreshToken = "refresh_token";

  /// Simulated refresh API
  Future<String> refreshAccessToken() async {
    await Future.delayed(const Duration(seconds: 2));

    accessToken = "new_access_token";

    return accessToken;
  }

  Future<bool> authenticate() async {
    return auth.authenticate(localizedReason: 'Authenticate to continue');
  }
}
