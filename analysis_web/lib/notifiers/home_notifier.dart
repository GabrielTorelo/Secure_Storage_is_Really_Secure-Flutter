import 'package:flutter/material.dart';

class HomeNotifier with ChangeNotifier {
  bool _displayDecrypted = false;

  bool get displayDecrypted => _displayDecrypted;

  set displayDecrypted(bool value) {
    _displayDecrypted = value;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
