import 'dart:convert';
import 'dart:typed_data';
import 'package:web/web.dart';
import 'package:analysis_web/controllers/auth_controller.dart';
import 'package:cryptography/cryptography.dart';
import 'package:analysis_web/data/local_storage.dart';
import 'package:analysis_web/notifiers/home_notifier.dart';
import 'package:flutter/material.dart';

class HomeController {
  final HomeNotifier homeNotifier;
  final AesGcm _algorithm = AesGcm.with256bits();
  final LocalStorage _localStorage = LocalStorage();

  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _encryptUserDataController =
      TextEditingController();
  final TextEditingController _decryptUserDataController =
      TextEditingController();
  final TextEditingController _newEncryptUserDataController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  TextEditingController get keyController => _keyController;
  TextEditingController get encryptUserDataController =>
      _encryptUserDataController;
  TextEditingController get decryptUserDataController =>
      _decryptUserDataController;
  TextEditingController get newEncryptUserDataController =>
      _newEncryptUserDataController;
  TextEditingController get nameController => _nameController;
  TextEditingController get usernameController => _usernameController;

  HomeController({
    required this.homeNotifier,
  });

  void changeName(String name) {
    _newEncryptUserDataController.text = _newEncryptUserDataController.text
        .replaceFirst(RegExp(r'"name":"[^"]*"'), '"name":"$name"');
  }

  void changeUsername(String username) {
    _newEncryptUserDataController.text = _newEncryptUserDataController.text
        .replaceFirst(RegExp(r'"username":"[^"]*"'), '"username":"$username"');
  }

  void reloadScreen() {
    window.location.reload();
  }

  void toggleAdmMode() {
    if (_newEncryptUserDataController.text.isEmpty) return;

    if (_newEncryptUserDataController.text.contains('"role":"admin"')) {
      _newEncryptUserDataController.text =
          _newEncryptUserDataController.text.replaceFirst(
        '"role":"admin"',
        '"role":"user"',
      );
      return;
    } else if (_newEncryptUserDataController.text.contains('"role":"user"')) {
      _newEncryptUserDataController.text =
          _newEncryptUserDataController.text.replaceFirst(
        '"role":"user"',
        '"role":"admin"',
      );
      return;
    } else {
      _newEncryptUserDataController.text = _newEncryptUserDataController.text
          .replaceFirst(RegExp(r'"role":"[^"]*"'), '"role":"admin"');
    }
  }

  void saveUserDataToLocalStorage() async {
    await _encryptUserData();
    await _localStorage.write(
      key: 'FlutterSecureStorage.userData',
      value: _newEncryptUserDataController.text,
    );
    homeNotifier.savedInLocalStorage = true;
  }

  void decryptUserData() async {
    _decryptUserDataController.text = await _decryptValue() ?? "";
    _newEncryptUserDataController.text = _decryptUserDataController.text;

    final userData = jsonDecode(_decryptUserDataController.text);

    _nameController.text = userData['name'] ?? "";
    _usernameController.text = userData['username'] ?? "";

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

  Future<void> _encryptUserData() async {
    _newEncryptUserDataController.text = await _encryptValue() ?? "";
    homeNotifier.displayNewEncrypted = true;
  }

  Future<String?> _encryptValue() async {
    final secretKey = SecretKey(base64Decode(_keyController.text));
    final nonce = _algorithm.newNonce();

    final secretBox = await _algorithm.encrypt(
      utf8.encode(_newEncryptUserDataController.text),
      secretKey: secretKey,
      nonce: nonce,
    );

    final combinedCipher = Uint8List.fromList([
      ...secretBox.cipherText,
      ...secretBox.mac.bytes,
    ]);

    return "${base64Encode(nonce)}.${base64Encode(combinedCipher)}";
  }

  Future<String?> _decryptValue() async {
    const tagLength = 16;
    final parts = _encryptUserDataController.text.split(".");
    final nonce = base64Decode(parts[0]);
    final encryptedCombined = base64Decode(parts[1]);

    if (encryptedCombined.length < tagLength) return null;

    return utf8.decode(
      await _algorithm.decrypt(
        SecretBox(
          encryptedCombined.sublist(0, encryptedCombined.length - tagLength),
          nonce: nonce,
          mac: Mac(
            encryptedCombined.sublist(encryptedCombined.length - tagLength),
          ),
        ),
        secretKey: SecretKey(
          base64Decode(
            _keyController.text,
          ),
        ),
      ),
    );
  }
}
