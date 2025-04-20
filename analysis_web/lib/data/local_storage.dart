import 'package:analysis_web/main.dart';
import 'package:localstorage/localstorage.dart';

class LocalStorage {
  Future<String> read({
    required String key,
    String defaultValue = '',
  }) async {
    try {
      return localStorage.getItem(key) ?? defaultValue;
    } catch (_) {
      logs.error('Error reading from local storage key: $key');
      return defaultValue;
    }
  }

  Future<void> write({
    required String key,
    required String value,
  }) async {
    try {
      localStorage.setItem(key, value);
    } catch (_) {
      logs.error('Error writing to local storage key: $key');
    }
  }
}
