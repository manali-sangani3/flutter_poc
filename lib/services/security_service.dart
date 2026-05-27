import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityService {
  final storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return storage.read(key: 'token');
  }
}
