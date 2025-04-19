import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:analysis_web/routes/app_routes.dart';
import 'package:analysis_web/helpers/text_handler.dart';
import 'package:analysis_web/l10n/app_localizations.dart';
import 'package:analysis_web/notifiers/home_notifier.dart';
import 'package:analysis_web/controllers/auth_controller.dart';
import 'package:analysis_web/controllers/home_controller.dart';
import 'package:analysis_web/components/dialog/home_dialog.dart';
import 'package:analysis_web/components/background_gradient.dart';
import 'package:analysis_web/components/buttons/default_elevated_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = Provider.of<HomeController>(context, listen: false);
    _homeController.getUserDataFromLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final AuthController authController = Provider.of<AuthController>(context);

    return Scaffold(
      body: BackgroundGradient(
        actionButtons: DefaultElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              AppRoutes.authOrHome,
            );
            _homeController.logout(authController);
          },
          text: localizations.logout,
          withoutBorderRadius: true,
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
                    ' ${authController.authNotifier.user.name} ',
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
              Text(
                localizations.savedLocalStorage,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.tertiary.withValues(
                        alpha: 0.9,
                      ),
                ),
                textAlign: TextAlign.center,
              ),
              Consumer<HomeNotifier>(
                builder: (ctx, homeNotifier, _) {
                  return Responsive(
                    children: [
                      _buildTextField(
                        title: localizations.encryptionKey,
                        controller: _homeController.keyController,
                      ),
                      _buildTextField(
                        title: localizations.encryptedUserData,
                        controller: _homeController.encryptUserDataController,
                      ),
                      Center(
                        child: homeNotifier.displayDecrypted
                            ? _buildTextField(
                                title: localizations.decryptedUserData,
                                controller:
                                    _homeController.decryptUserDataController,
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: DefaultElevatedButton(
                                  onPressed: () =>
                                      _homeController.decryptUserData(),
                                  text: localizations.decrypt,
                                ),
                              ),
                      ),
                    ],
                  );
                },
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
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Tooltip(
                          message:
                              AppLocalizations.of(context)!.whereAccessInfo,
                          waitDuration: Duration(milliseconds: 300),
                          child: IconButton(
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
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: controller,
                    enabled: false,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'SecureStorage - $title',
                      border: OutlineInputBorder(),
                      fillColor: Theme.of(context).colorScheme.tertiary,
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Tooltip(
                message: controller.text.isEmpty
                    ? '${AppLocalizations.of(context)!.copy} ${AppLocalizations.of(context)!.unavailable.toLowerCase()}'
                    : AppLocalizations.of(context)!.copy,
                waitDuration: Duration(milliseconds: 300),
                child: IconButton(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
