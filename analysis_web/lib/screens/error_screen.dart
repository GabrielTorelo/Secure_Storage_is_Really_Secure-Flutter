import 'package:analysis_web/components/background_gradient.dart';
import 'package:analysis_web/components/buttons/default_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:analysis_web/routes/app_routes.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: BackgroundGradient(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Icon(
                Icons.error_outline,
                size: 100,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text(
                  localizations.unknownErrorOccurred,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            DefaultElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authOrHome);
              },
              text: localizations.backToHome,
            )
          ],
        ),
      ),
    );
  }
}
