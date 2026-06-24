import 'package:flutter_test/flutter_test.dart';

import 'mocks/mock_auth_service.dart';

void main() {
  late MockAuthService authService;

  setUp(() {
    authService = MockAuthService();
  });

  test('Valid credentials should return true', () {
    expect(authService.validateLogin('test@gmail.com', '123456'), true);
  });

  test('Invalid password should return false', () {
    expect(authService.validateLogin('test@gmail.com', '123'), false);
  });
}
