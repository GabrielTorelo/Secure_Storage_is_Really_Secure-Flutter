import 'package:flutter/material.dart';

class HomeNotifier with ChangeNotifier {
  bool _displayDecrypted = false;
  bool _displayNewEncrypted = false;
  bool _savedInLocalStorage = false;

  bool get displayDecrypted => _displayDecrypted;
  bool get displayNewEncrypted => _displayNewEncrypted;
  bool get savedInLocalStorage => _savedInLocalStorage;

  set displayDecrypted(bool value) {
    _displayDecrypted = value;
    notifyListeners();
  }

  set displayNewEncrypted(bool value) {
    _displayNewEncrypted = value;
    notifyListeners();
  }

  set savedInLocalStorage(bool value) {
    _savedInLocalStorage = value;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
