import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:analysis_web/routes/app_routes.dart';
import 'package:analysis_web/helpers/text_handler.dart';
import 'package:analysis_web/notifier/auth_notifier.dart';
import 'package:analysis_web/components/dialog/home_dialog.dart';
import 'package:analysis_web/components/background_gradient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_ui/responsive_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      body: BackgroundGradient(
        actionButtons: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              AppRoutes.authOrHome,
            );
            authNotifier.logout();
          },
          child: Text(localizations.logout),
        ),
        actionDirection: Direction.right,
        content: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localizations.welcome,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  Text(
                    ' ${authNotifier.user.name} ',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Text(
                    localizations.toTheApp,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  localizations.savedLocalStorage,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.tertiary.withValues(
                          alpha: 0.9,
                        ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Responsive(
                children: [
                  _buildTextField(
                    title: localizations.encryptionKey,
                    controller: authNotifier.keyController,
                  ),
                  _buildTextField(
                    title: localizations.encryptedUserData,
                    controller: authNotifier.userDataController,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String title,
    required TextEditingController controller,
  }) {
    return Div(
      divison: Division(
        colL: 6,
        colS: 12,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.help,
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withValues(alpha: 0.5),
                        ),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => HomeDialog(),
                        ),
                      ),
                    ],
                  ),
                  Consumer<AuthNotifier>(
                    builder: (ctx, authNotifier, _) {
                      return TextField(
                        controller: controller,
                        enabled: false,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'SecureStorage - $title',
                          border: OutlineInputBorder(),
                          fillColor: Theme.of(context).colorScheme.tertiary,
                          filled: true,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Consumer<AuthNotifier>(
              builder: (ctx, authNotifier, _) {
                return IconButton(
                  icon: Icon(
                    Icons.copy,
                    color: controller.text.isEmpty
                        ? Theme.of(context).colorScheme.outline
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: controller.text.isEmpty
                      ? null
                      : () => TextHandler.of(context).copyToClipboard(
                            text: controller.text,
                          ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
