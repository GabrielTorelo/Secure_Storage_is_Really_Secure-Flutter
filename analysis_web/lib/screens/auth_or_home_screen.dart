import 'package:analysis_web/components/background_gradient.dart';
import 'package:analysis_web/controllers/auth_controller.dart';
import 'package:analysis_web/notifiers/auth_notifier.dart';
import 'package:analysis_web/screens/auth_screen.dart';
import 'package:analysis_web/screens/error_screen.dart';
import 'package:analysis_web/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Provider.of<AuthController>(context);

    return FutureBuilder(
      future: authController.tryAutoLogin(),
      builder: (ctx, snapshot) {
        return Consumer<AuthNotifier>(
          builder: (ctx, authNotifier, _) {
            return switch (snapshot.connectionState) {
              ConnectionState.waiting => Scaffold(
                  body: BackgroundGradient(
                    content: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ConnectionState.done =>
                authNotifier.isAuth ? const HomeScreen() : const AuthScreen(),
              _ => const ErrorScreen(),
            };
          },
        );
      },
    );
  }
}
