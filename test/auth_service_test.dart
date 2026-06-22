import 'package:flutter_poc/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/mock_auth_service.dart';

void main() {
  late MockAuthService authService;

  setUp(() {
    authService = MockAuthService();
  });

  test('Validate login', () {
    final authService = AuthService();

    expect(authService.validateLogin('test@gmail.com', '123456'), true);
  });
}
