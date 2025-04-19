import 'package:analysis_web/data/local_storage.dart';
import 'package:analysis_web/notifiers/home_notifier.dart';
// import 'package:analysis_web/data/secure_storage.dart';
import 'package:flutter/material.dart';

class HomeController {
  final HomeNotifier homeNotifier;
  final LocalStorage _localStorage = LocalStorage();
  // final SecureStorage _secureStorage = SecureStorage();

  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _encryptUserDataController =
      TextEditingController();
  final TextEditingController _decryptUserDataController =
      TextEditingController();

  TextEditingController get keyController => _keyController;
  TextEditingController get encryptUserDataController =>
      _encryptUserDataController;
  TextEditingController get decryptUserDataController =>
      _decryptUserDataController;

  HomeController({
    required this.homeNotifier,
  });

  void decryptUserData() {
    homeNotifier.displayDecrypted = true;
  }

  Future<void> getUserDataFromLocalStorage() async {
    _keyController.text = await _localStorage.read(key: 'FlutterSecureStorage');
    _encryptUserDataController.text = await _localStorage.read(
      key: 'FlutterSecureStorage.userData',
    );

    homeNotifier.notify();
  }
}
