import 'dart:math';
import 'package:flutter/material.dart';
import 'package:analysis_web/components/auth_form.dart';
import 'package:analysis_web/components/dialog/auth_dialog.dart';
import 'package:analysis_web/components/background_gradient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:analysis_web/components/buttons/default_elevated_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: BackgroundGradient(
        actionButtons: DefaultElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AuthDialog(),
            );
          },
          text: localizations.users,
          color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
          withoutBorderRadius: true,
        ),
        content: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 70,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Theme.of(context).colorScheme.shadow,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  localizations.appTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const AuthForm(),
            ],
          ),
        ),
      ),
    );
  }
}
