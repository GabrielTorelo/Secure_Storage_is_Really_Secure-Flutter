import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralException implements Exception {
  final String title;
  final String message;
  final BuildContext context;

  GeneralException({
    String? title,
    required this.message,
    required this.context,
  }) : title = title ?? AppLocalizations.of(context)!.errorOccurred;
}
