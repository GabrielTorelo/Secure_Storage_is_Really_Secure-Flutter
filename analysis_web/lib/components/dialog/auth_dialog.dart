import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:analysis_web/MOCK/users.dart';
import 'package:analysis_web/models/user.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:analysis_web/l10n/app_localizations.dart';
import 'package:analysis_web/controllers/auth_controller.dart';
import 'package:analysis_web/components/dialog/tip_dialog.dart';

class AuthDialog extends StatelessWidget {
  const AuthDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final AuthController authController = Provider.of<AuthController>(context);

    return TipDialog(
      title: localizations.usersAvailable,
      content: Responsive(
        children: [
          Text(
            localizations.usersAvailableDesc,
            style: TextStyle(color: Colors.grey.shade800),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Div(
              divison: Division(
                colM: 6,
                colS: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    '${localizations.users}:',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  ...Users.usersList.map(
                    (user) => Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${localizations.name}: ${user.name}\n'
                            '${localizations.username}: ${user.username}\n'
                            '${localizations.password}: ${user.password}\n'
                            '${localizations.role}: ${user.role}',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Tooltip(
                            message: localizations.insertDataAuto,
                            waitDuration: Duration(milliseconds: 300),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: const CircleBorder(),
                                splashFactory: InkSplash.splashFactory,
                              ),
                              child: Icon(
                                Icons.insert_link_sharp,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                _setAuthData(
                                  authController: authController,
                                  user: user,
                                );

                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Div(
              divison: Division(
                colM: 6,
                colS: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.whereUsersStored,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${localizations.whereUsersStoredDesc}.\n',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Stack(
                          children: [
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(50),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: InteractiveViewer(
                                    panEnabled: true,
                                    boundaryMargin: EdgeInsets.all(100),
                                    minScale: 0.5,
                                    maxScale: 2,
                                    child: Image.asset(
                                      'assets/images/tips/users/accessing_users.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Image.asset(
                        'assets/images/tips/users/accessing_users.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _setAuthData({
    required AuthController authController,
    required User user,
  }) {
    authController.usernameController.text = user.username;
    authController.passwordController.text = user.password;
  }
}
