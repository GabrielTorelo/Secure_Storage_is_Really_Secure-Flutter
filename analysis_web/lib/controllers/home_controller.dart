import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:js_util' as js_util;
import 'package:analysis_web/controllers/auth_controller.dart';
import 'package:flutter_secure_storage_web/src/subtle.dart' as crypto;
import 'package:analysis_web/data/local_storage.dart';
import 'package:analysis_web/notifiers/home_notifier.dart';
import 'package:flutter/material.dart';

class HomeController {
  final HomeNotifier homeNotifier;
  final LocalStorage _localStorage = LocalStorage();

  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _encryptUserDataController =
      TextEditingController();
  final TextEditingController _decryptUserDataController =
      TextEditingController();
  final TextEditingController _newEncryptUserDataController =
      TextEditingController();

  TextEditingController get keyController => _keyController;
  TextEditingController get encryptUserDataController =>
      _encryptUserDataController;
  TextEditingController get decryptUserDataController =>
      _decryptUserDataController;
  TextEditingController get newCncryptUserDataController =>
      _newEncryptUserDataController;

  HomeController({
    required this.homeNotifier,
  });

  void encryptUserData() async {
    _newEncryptUserDataController.text = await _encryptValue() ?? "";
    homeNotifier.displayNewEncrypted = true;
  }

  void decryptUserData() async {
    _decryptUserDataController.text = await _decryptValue() ?? "";
    homeNotifier.displayDecrypted = true;
  }

  Future<void> getUserDataFromLocalStorage() async {
    _keyController.text = await _localStorage.read(key: 'FlutterSecureStorage');
    _encryptUserDataController.text = await _localStorage.read(
      key: 'FlutterSecureStorage.userData',
    );

    homeNotifier.notify();
  }

  void logout(AuthController authController) {
    homeNotifier.displayDecrypted = false;
    decryptUserDataController.clear();
    authController.logout();
  }

  Future<String?> _encryptValue() async {
    final iv =
        html.window.crypto!.getRandomValues(Uint8List(12)).buffer.asUint8List();
    final algorithm = _getAlgorithm(iv);
    final encryptionKey = await _getEncryptionKey(algorithm);

    final encryptedContent = await js_util.promiseToFuture<ByteBuffer>(
      crypto.encrypt(
        algorithm,
        encryptionKey,
        Uint8List.fromList(
          utf8.encode(_newEncryptUserDataController.text),
        ),
      ),
    );

    return "${base64Encode(iv)}.${base64Encode(encryptedContent.asUint8List())}";
  }

  Future<String?> _decryptValue() async {
    final parts = _encryptUserDataController.text.split(".");

    final iv = base64Decode(parts[0]);
    final value = base64Decode(parts[1]);
    final algorithm = _getAlgorithm(iv);
    final decryptionKey = await _getEncryptionKey(algorithm);

    final decryptedContent = await js_util.promiseToFuture<ByteBuffer>(
      crypto.decrypt(
        algorithm,
        decryptionKey,
        Uint8List.fromList(value),
      ),
    );

    return utf8.decode(decryptedContent.asUint8List());
  }

  crypto.Algorithm _getAlgorithm(Uint8List iv) {
    return crypto.Algorithm(
      name: 'AES-GCM',
      length: 256,
      iv: iv,
    );
  }

  Future<html.CryptoKey> _getEncryptionKey(crypto.Algorithm algorithm) async {
    final jwk = base64Decode(_keyController.text);

    return await js_util.promiseToFuture<html.CryptoKey>(
      crypto.importKey("raw", jwk, algorithm, false, ["encrypt", "decrypt"]),
    );
  }
}
