import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._();
  static SecureStorageService get instance => _instance;

  final FlutterSecureStorage _storage;

  // Storage keys
  static const String usernameKey = 'username';
  static const String passwordKey = 'password';

  SecureStorageService._()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
        );

  /// Save username and password
  Future<void> saveCredentials({
    required String username,
    required String password,
  }) async {
    await _storage.write(key: usernameKey, value: username);
    await _storage.write(key: passwordKey, value: password);
  }

  /// Read username
  Future<String?> getUsername() async {
    return await _storage.read(key: usernameKey);
  }

  /// Read password
  Future<String?> getPassword() async {
    return await _storage.read(key: passwordKey);
  }

  /// Delete username and password
  Future<void> deleteCredentials() async {
    await _storage.delete(key: usernameKey);
    await _storage.delete(key: passwordKey);
  }

  /// Delete all data from secure storage
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Check if credentials exist
  Future<bool> hasCredentials() async {
    final username = await getUsername();
    final password = await getPassword();
    return username != null && password != null;
  }
}
