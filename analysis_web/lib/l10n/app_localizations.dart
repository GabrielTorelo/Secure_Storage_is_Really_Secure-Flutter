import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'\'Login\' App'**
  String get appTitle;

  /// Generic error title
  ///
  /// In en, this message translates to:
  /// **'Error occurred'**
  String get errorOccurred;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred!\nTry again later.'**
  String get unknownErrorOccurred;

  /// Login error title
  ///
  /// In en, this message translates to:
  /// **'Login Error'**
  String get errorLogin;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Login text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Logout text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Message to return to home
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// Ok text
  ///
  /// In en, this message translates to:
  /// **'ok'**
  String get ok;

  /// Edit text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Unavailable text
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unavailable;

  /// Press text
  ///
  /// In en, this message translates to:
  /// **'Press'**
  String get press;

  /// Text to close something
  ///
  /// In en, this message translates to:
  /// **'to close'**
  String get toClose;

  /// Copy text
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// Text to save in 'Local Storage'
  ///
  /// In en, this message translates to:
  /// **'Save in Local Storage'**
  String get saveLocalStorage;

  /// Reload screen text
  ///
  /// In en, this message translates to:
  /// **'Reload screen'**
  String get reloadScreen;

  /// Text referring to the ESC key
  ///
  /// In en, this message translates to:
  /// **'[ESC]'**
  String get keyESC;

  /// Users text
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// Users available text
  ///
  /// In en, this message translates to:
  /// **'Users available for login'**
  String get usersAvailable;

  /// Text indicating that you can use the users to login
  ///
  /// In en, this message translates to:
  /// **'You can use the following users to login in the application:'**
  String get usersAvailableDesc;

  /// Text to refer to the name of the user
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Text to refer to the username
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// Text to refer to the user password
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Text to refer to the user role
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// Text to insert data automatically
  ///
  /// In en, this message translates to:
  /// **'Insert data automatically'**
  String get insertDataAuto;

  /// Error message when user is not found
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// Error message when password is incorrect
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get incorrectPassword;

  /// Message to enter a username
  ///
  /// In en, this message translates to:
  /// **'Please enter a username'**
  String get pleaseEnterUsername;

  /// Message to enter a password
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get pleaseEnterPassword;

  /// Copied text message
  ///
  /// In en, this message translates to:
  /// **'Text copied'**
  String get textCopied;

  /// Message asking where to access this information
  ///
  /// In en, this message translates to:
  /// **'Where to access this information?'**
  String get whereAccessInfo;

  /// Message to encrypt something
  ///
  /// In en, this message translates to:
  /// **'Encrypt'**
  String get encrypt;

  /// Message to decrypt something
  ///
  /// In en, this message translates to:
  /// **'Decrypt'**
  String get decrypt;

  /// Text of the field containing the encryption key
  ///
  /// In en, this message translates to:
  /// **'Encryption Key'**
  String get encryptionKey;

  /// Text of the field containing the user data
  ///
  /// In en, this message translates to:
  /// **'User Data'**
  String get userData;

  /// Text of the field containing the encrypted user data
  ///
  /// In en, this message translates to:
  /// **'Encrypted User Data'**
  String get encryptedUserData;

  /// Text of the field containing the decrypted user data
  ///
  /// In en, this message translates to:
  /// **'Decrypted User Data'**
  String get decryptedUserData;

  /// Message to indicate that data has been saved in 'LocalStorage'
  ///
  /// In en, this message translates to:
  /// **'Your data has been saved in \'Local Storage\' using the \'flutter_secure_storage\' package'**
  String get savedLocalStorage;

  /// Message referring to the application
  ///
  /// In en, this message translates to:
  /// **'to the \'Login\' App'**
  String get toTheApp;

  /// Message asking where the users are stored
  ///
  /// In en, this message translates to:
  /// **'Where are users stored?'**
  String get whereUsersStored;

  /// Message indicating where the users are stored
  ///
  /// In en, this message translates to:
  /// **'The users are stored in the file \'users.dart\' in the folder \'MOCK\''**
  String get whereUsersStoredDesc;

  /// Message asking how to access local storage information through the browser
  ///
  /// In en, this message translates to:
  /// **'How can I access this information through the browser?'**
  String get howAccessBrowserLS;

  /// Message about how to access local storage information through the browser's DevTools
  ///
  /// In en, this message translates to:
  /// **'You can access this information through your browser \'DevTools\'. The example below uses the'**
  String get accessBrowserDevTools;

  /// 'HomeDialog' first step message
  ///
  /// In en, this message translates to:
  /// **'1º Open the browser DevTools (F12) and go to the \'Application\' tab.'**
  String get homeDialogStepOne;

  /// Mensagem do segundo passo do 'HomeDialog'
  ///
  /// In en, this message translates to:
  /// **'2º In the \'Storage\' section, click on \'Local Storage\' and select the site you want to inspect. You will see the keys and values stored in the \'Local Storage\'.'**
  String get homeDialogStepTwo;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
