import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextHandler {
  final BuildContext context;

  const TextHandler._(this.context);

  static TextHandler of(BuildContext context) {
    return TextHandler._(context);
  }

  void copyToClipboard({required String text, popAfterCopy = false}) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${AppLocalizations.of(context)!.textCopied}!',
        ),
      ),
    );

    if (popAfterCopy) {
      Navigator.of(context).pop();
    }
  }
}
