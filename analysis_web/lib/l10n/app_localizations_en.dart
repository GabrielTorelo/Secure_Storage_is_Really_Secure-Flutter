// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => '\'Login\' App';

  @override
  String get errorOccurred => 'Error occurred';

  @override
  String get unknownErrorOccurred => 'An unknown error occurred!\nTry again later.';

  @override
  String get errorLogin => 'Login Error';

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get ok => 'ok';

  @override
  String get edit => 'Edit';

  @override
  String get unavailable => 'Unavailable';

  @override
  String get press => 'Press';

  @override
  String get toClose => 'to close';

  @override
  String get copy => 'Copy';

  @override
  String get saveLocalStorage => 'Save in Local Storage';

  @override
  String get reloadScreen => 'Reload screen';

  @override
  String get keyESC => '[ESC]';

  @override
  String get users => 'Users';

  @override
  String get usersAvailable => 'Users available for login';

  @override
  String get usersAvailableDesc => 'You can use the following users to login in the application:';

  @override
  String get name => 'Name';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get role => 'Role';

  @override
  String get insertDataAuto => 'Insert data automatically';

  @override
  String get userNotFound => 'User not found';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get pleaseEnterUsername => 'Please enter a username';

  @override
  String get pleaseEnterPassword => 'Please enter a password';

  @override
  String get textCopied => 'Text copied';

  @override
  String get whereAccessInfo => 'Where to access this information?';

  @override
  String get encrypt => 'Encrypt';

  @override
  String get decrypt => 'Decrypt';

  @override
  String get encryptionKey => 'Encryption Key';

  @override
  String get userData => 'User Data';

  @override
  String get encryptedUserData => 'Encrypted User Data';

  @override
  String get decryptedUserData => 'Decrypted User Data';

  @override
  String get savedLocalStorage => 'Your data has been saved in \'Local Storage\' using the \'flutter_secure_storage\' package';

  @override
  String get toTheApp => 'to the \'Login\' App';

  @override
  String get whereUsersStored => 'Where are users stored?';

  @override
  String get whereUsersStoredDesc => 'The users are stored in the file \'users.dart\' in the folder \'MOCK\'';

  @override
  String get howAccessBrowserLS => 'How can I access this information through the browser?';

  @override
  String get accessBrowserDevTools => 'You can access this information through your browser \'DevTools\'. The example below uses the';

  @override
  String get homeDialogStepOne => '1º Open the browser DevTools (F12) and go to the \'Application\' tab.';

  @override
  String get homeDialogStepTwo => '2º In the \'Storage\' section, click on \'Local Storage\' and select the site you want to inspect. You will see the keys and values stored in the \'Local Storage\'.';
}
