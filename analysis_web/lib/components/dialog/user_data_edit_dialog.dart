import 'package:analysis_web/components/buttons/default_elevated_button.dart';
import 'package:analysis_web/controllers/home_controller.dart';
import 'package:analysis_web/helpers/text_handler.dart';
import 'package:analysis_web/notifiers/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:analysis_web/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class UserDataEditDialog extends StatelessWidget {
  const UserDataEditDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context, listen: false);
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Consumer<HomeNotifier>(
      builder: (ctx, homeNotifier, _) {
        return AlertDialog(
          title: Text("${localizations.edit} - ${localizations.userData}"),
          content: TextFormField(
            enabled: !homeNotifier.displayNewEncrypted,
            controller: homeController.newEncryptUserDataController,
            textAlign: TextAlign.start,
          ),
          actions: [
            Column(
              children: [
                if (!homeNotifier.displayNewEncrypted) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: homeController.nameController,
                          textAlign: TextAlign.center,
                          onChanged: homeController.changeName,
                          maxLength: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Expanded(
                          child: TextFormField(
                            controller: homeController.usernameController,
                            textAlign: TextAlign.center,
                            onChanged: homeController.changeUsername,
                            maxLength: 8,
                          ),
                        ),
                      ),
                      Expanded(
                        child: DefaultElevatedButton(
                          onPressed: homeController.toggleAdmMode,
                          text: localizations.role.toUpperCase(),
                          color: Theme.of(context).colorScheme.secondary,
                          withoutBorderRadius: true,
                        ),
                      ),
                    ],
                  ),
                ],
                if (!homeNotifier.savedInLocalStorage) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: DefaultElevatedButton(
                        onPressed: homeController.saveUserDataToLocalStorage,
                        text: localizations.saveLocalStorage.toUpperCase(),
                      ),
                    ),
                  ),
                ],
                if (homeNotifier.displayNewEncrypted) ...[
                  SizedBox(
                    width: double.infinity,
                    child: DefaultElevatedButton(
                      onPressed: () => TextHandler.of(context).copyToClipboard(
                        text: homeController.newEncryptUserDataController.text,
                      ),
                      text: localizations.copy.toUpperCase(),
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: DefaultElevatedButton(
                        onPressed: homeController.reloadScreen,
                        text: localizations.reloadScreen.toUpperCase(),
                        color:
                            Theme.of(context).colorScheme.onPrimaryFixedVariant,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            Text(
              "${localizations.press} ${localizations.keyESC} ${localizations.toClose}",
              style: const TextStyle(
                fontSize: 11,
                color: Colors.blueGrey,
              ),
            ),
          ],
        );
      },
    );
  }
}
