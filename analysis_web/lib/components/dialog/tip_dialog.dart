import 'package:flutter/material.dart';
import 'package:analysis_web/l10n/app_localizations.dart';
import 'package:analysis_web/components/buttons/default_elevated_button.dart';

class TipDialog extends StatelessWidget {
  final String title;
  final Widget content;

  const TipDialog({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 600,
              child: content,
            ),
          ),
          actions: [
            DefaultElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              text: AppLocalizations.of(context)!.ok.toUpperCase(),
            ),
          ],
        ),
      ],
    );
  }
}
