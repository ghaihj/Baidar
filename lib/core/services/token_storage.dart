import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage storage;
  TokenStorage(this.storage);

  static const keytok = 'auth_token';

  Future<void> save(String token) => storage.write(key: keytok, value: token);
  Future<String?> read() => storage.read(key: keytok);
  Future<void> clear() => storage.delete(key: keytok);
}
