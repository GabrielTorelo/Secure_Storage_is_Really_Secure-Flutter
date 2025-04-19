import 'package:flutter/material.dart';
import 'package:analysis_web/main.dart';
import 'package:analysis_web/MOCK/users.dart';
import 'package:analysis_web/models/user.dart';
import 'package:analysis_web/data/secure_storage.dart';
import 'package:analysis_web/err/login_exception.dart';
import 'package:analysis_web/notifiers/auth_notifier.dart';
import 'package:analysis_web/l10n/app_localizations.dart';

class AuthController {
  final AuthNotifier authNotifier;
  final SecureStorage _secureStorage = SecureStorage();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;

  AuthController({
    required this.authNotifier,
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

    authNotifier.isAuth = true;
  }

  void logout() {
    authNotifier.user = User();
    authNotifier.isAuth = false;

    _secureStorage.delete(key: 'userData');
  }
}
