import 'package:flutter/material.dart';
import 'package:analysis_web/main.dart';
import 'package:analysis_web/MOCK/users.dart';
import 'package:analysis_web/models/user.dart';
import 'package:analysis_web/data/local_storage.dart';
import 'package:analysis_web/data/secure_storage.dart';
import 'package:analysis_web/err/login_exception.dart';
import 'package:analysis_web/notifiers/auth_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:analysis_web/controllers/home_controller.dart';

class AuthController {
  final AuthNotifier authNotifier;
  final HomeController homeController;
  final LocalStorage _localStorage = LocalStorage();
  final SecureStorage _secureStorage = SecureStorage();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;

  AuthController({
    required this.authNotifier,
    required this.homeController,
  });

  void handleLogin({required User auth}) async {
    final context = navigatorKey.currentContext;

    if (context == null) return;

    final localizations = AppLocalizations.of(context)!;

    authNotifier.isLoading = true;

    final user = Users.usersList.firstWhere(
      (usr) => usr.username == auth.username,
      orElse: () => User(),
    );

    if (user.id == 0) {
      authNotifier.isLoading = false;
      throw LoginException(
        context: context,
        message: localizations.userNotFound,
      );
    }

    final correctPassword = (user.password == auth.password);

    if (correctPassword) {
      await _secureStorage.saveMultiple(
        key: 'userData',
        value: user.toJsonWithoutData(
          fieldsToIgnore: [
            UserFields.password,
          ],
        ),
      );

      await _getFromLocalStorage();

      authNotifier.user = user;
      authNotifier.isLoading = false;
      authNotifier.isAuth = true;
    } else {
      authNotifier.isLoading = false;
      throw LoginException(
        context: context,
        message: localizations.incorrectPassword,
      );
    }
  }

  Future<void> tryAutoLogin() async {
    if (authNotifier.isAuth) return;

    final userData = await _secureStorage.readMultiple(key: 'userData');

    if (userData.isEmpty) return;

    authNotifier.user = User(
      id: userData['userId'],
      name: userData['name'],
      username: userData['username'],
      password: userData['password'],
      role: userData['role'],
    );

    await _getFromLocalStorage();

    authNotifier.isAuth = true;
  }

  void logout() {
    authNotifier.user = User();
    authNotifier.isAuth = false;

    _secureStorage.delete(key: 'userData');
  }

  Future<void> _getFromLocalStorage() async {
    homeController.keyController.text =
        await _localStorage.read(key: 'FlutterSecureStorage');
    homeController.encryptUserDataController.text = await _localStorage.read(
      key: 'FlutterSecureStorage.userData',
    );
  }
}
