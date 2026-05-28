class MockAuthService {
  Future<String> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    /// Fake token
    return "mock_secure_token";
  }
}
