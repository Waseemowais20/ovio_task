import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._();

  static final SecureStorageService _instance = SecureStorageService._();

  factory SecureStorageService() => _instance;

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> write({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> read({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> delete({required String key}) async {
    await _secureStorage.delete(key: key);
  }
}
