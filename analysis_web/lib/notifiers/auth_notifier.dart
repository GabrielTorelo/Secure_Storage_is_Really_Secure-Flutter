import 'package:flutter/material.dart';
import 'package:analysis_web/main.dart';
import 'package:analysis_web/MOCK/users.dart';
import 'package:analysis_web/models/user.dart';
import 'package:analysis_web/data/local_storage.dart';
import 'package:analysis_web/data/secure_storage.dart';
import 'package:analysis_web/err/login_exception.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthNotifier with ChangeNotifier {
  final SecureStorage _store = SecureStorage();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _encryptUserDataController =
      TextEditingController();
  final TextEditingController _decryptUserDataController =
      TextEditingController();
  User _user = User();
  bool _isLoading = false;
  bool _isAuth = false;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isAuth(bool value) {
    _isAuth = value;
    notifyListeners();
  }

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get keyController => _keyController;
  TextEditingController get encryptUserDataController =>
      _encryptUserDataController;
  TextEditingController get decryptUserDataController =>
      _decryptUserDataController;
  User get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuth => _isAuth;

  void handleLogin({
    required BuildContext ctx,
    required User auth,
  }) async {
    _isLoading = true;

    final user = Users.usersList.firstWhere(
      (usr) => usr.username == auth.username,
      orElse: () => User(),
    );

    if (user.id == 0) {
      _isLoading = false;
      throw LoginException(
        context: ctx,
        message: AppLocalizations.of(ctx)!.userNotFound,
      );
    }

    final correctPassword = user.password == auth.password;

    if (correctPassword) {
      final SecureStorage secureStorage = SecureStorage();

      logs.sucess('User logged in: ${user.username}');

      await secureStorage.saveMultiple(
        key: 'userData',
        value: user.toJsonWithoutData(
          fieldsToIgnore: [
            UserFields.password,
          ],
        ),
      );

      await _getFromLocalStorage();

      _user = user;
      _isLoading = false;
      _isAuth = true;
    } else {
      _isLoading = false;
      throw LoginException(
        context: ctx,
        message: AppLocalizations.of(ctx)!.incorrectPassword,
      );
    }

    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    logs.highlight('Trying to auto login');

    if (isAuth) return;

    final userData = await _store.readMultiple(key: 'userData');

    if (userData.isEmpty) return;

    _user = User(
      id: userData['userId'],
      name: userData['name'],
      username: userData['username'],
      password: userData['password'],
      role: userData['role'],
    );

    await _getFromLocalStorage();

    _isAuth = true;

    notifyListeners();
  }

  void logout() {
    _user = User();
    _isAuth = false;

    _store.delete(key: 'userData').then((_) => notifyListeners());
  }

  Future<void> _getFromLocalStorage() async {
    final LocalStorage localStorage = LocalStorage();

    _keyController.text = await localStorage.read(key: 'FlutterSecureStorage');
    _encryptUserDataController.text = await localStorage.read(
      key: 'FlutterSecureStorage.userData',
    );
  }
}
