import 'package:flutter/material.dart';
import 'package:analysis_web/l10n/app_localizations.dart';

class DefaultElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color? color;
  final bool withoutBorderRadius;

  const DefaultElevatedButton({
    super.key,
    this.onPressed,
    this.text,
    this.color,
    this.withoutBorderRadius = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: !withoutBorderRadius
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              )
            : null,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 8,
        ),
        backgroundColor: color ?? Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      child: Text(
        text ?? AppLocalizations.of(context)!.ok,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
