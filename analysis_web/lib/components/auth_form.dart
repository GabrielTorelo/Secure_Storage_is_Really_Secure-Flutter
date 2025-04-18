import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:analysis_web/models/user.dart';
import 'package:analysis_web/notifier/auth_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_usernameFocusNode);
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _handleLogin({required AuthNotifier notifier, required User user}) {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    notifier.handleLogin(ctx: context, auth: user);
  }

  @override
  Widget build(BuildContext context) {
    final AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: SizedBox(
            width: deviceSize.width * 0.65,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    focusNode: _usernameFocusNode,
                    decoration: InputDecoration(
                      labelText: localizations.username,
                    ),
                    keyboardType: TextInputType.name,
                    controller: authNotifier.usernameController,
                    validator: (value) {
                      return switch (value?.trim()) {
                        '' || null => localizations.pleaseEnterUsername,
                        _ => null,
                      };
                    },
                  ),
                  TextFormField(
                    focusNode: _passwordFocusNode,
                    decoration: InputDecoration(
                      labelText: localizations.password,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: authNotifier.passwordController,
                    validator: (value) {
                      return switch (value?.trim()) {
                        '' || null => localizations.pleaseEnterPassword,
                        _ => null,
                      };
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: authNotifier.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () => _handleLogin(
                              notifier: authNotifier,
                              user: User(
                                username: authNotifier.usernameController.text,
                                password: authNotifier.passwordController.text,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 8,
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(localizations.login.toUpperCase()),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
