import 'dart:convert';
import 'package:analysis_web/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future<bool> save({required String key, required String value}) async {
    try {
      await _storage.write(key: key, value: value);
      return true;
    } catch (_) {
      logs.error('Error saving key: $key');
      return false;
    }
  }

  Future<bool> saveMultiple({
    required String key,
    required Map<String, dynamic> value,
  }) async {
    try {
      return save(key: key, value: jsonEncode(value));
    } catch (_) {
      logs.error('Error saving multiple keys: $key');
      return false;
    }
  }

  Future<String> read({
    required String key,
    String defaultValue = '',
  }) async {
    try {
      return await _storage.read(key: key) ?? defaultValue;
    } catch (_) {
      logs.error('Error reading key: $key');
      return defaultValue;
    }
  }

  Future<Map<String, dynamic>> readMultiple({
    required String key,
    Map<String, dynamic> defaultValue = const {},
  }) async {
    try {
      return jsonDecode(
        await read(
          key: key,
          defaultValue: defaultValue.toString(),
        ),
      );
    } catch (_) {
      logs.error('Error reading multiple keys: $key');
      return defaultValue;
    }
  }

  Future<bool> delete({required String key}) async {
    try {
      await _storage.delete(key: key);
      return true;
    } catch (_) {
      logs.error('Error deleting key: $key');
      return false;
    }
  }
}
