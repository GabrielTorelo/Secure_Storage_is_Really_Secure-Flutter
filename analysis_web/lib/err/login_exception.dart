import 'package:analysis_web/err/general_exception.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginException extends GeneralException {
  LoginException({
    required super.message,
    required super.context,
  }) : super(title: AppLocalizations.of(context)!.errorLogin);
}
