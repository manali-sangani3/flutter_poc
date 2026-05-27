import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureVaultService {
  /// OS-level protected storage
  final storage = const FlutterSecureStorage();

  /// AES (Advanced Encryption Standard) KEY: Secure data transformation
  final key = encrypt.Key.fromSecureRandom(32);

  final iv = encrypt.IV.fromLength(16);

  /// SAVE ENCRYPTED NOTE: Secure architecture
  Future<void> saveNote(String note) async {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(note, iv: iv);

    await storage.write(key: 'secure_note', value: encrypted.base64);
  }

  /// READ & DECRYPT NOTE: Secure retrieval
  Future<String> getNote() async {
    try {
      final encryptedValue = await storage.read(key: 'secure_note');

      if (encryptedValue == null) {
        return '';
      }

      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      final decrypted = encrypter.decrypt64(encryptedValue, iv: iv);

      return decrypted;
    } catch (e) {
      return "Decryption Failed";
    }
  }
}
