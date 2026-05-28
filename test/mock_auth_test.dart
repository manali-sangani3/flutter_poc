import 'package:flutter_poc/services/mock_auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockAuthService', () {
    test('returns mock token', () async {
      final service = MockAuthService();

      final token = await service.login('demo@gmail.com', '123456');

      expect(token, isNotEmpty);
    });
  });
}
