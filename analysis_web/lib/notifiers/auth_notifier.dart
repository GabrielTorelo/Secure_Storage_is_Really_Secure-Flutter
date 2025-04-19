import 'package:flutter/material.dart';
import 'package:analysis_web/models/user.dart';

class AuthNotifier with ChangeNotifier {
  User _user = User();
  bool _isLoading = false;
  bool _isAuth = false;

  User get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuth => _isAuth;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isAuth(bool value) {
    _isAuth = value;
    notifyListeners();
  }
}
