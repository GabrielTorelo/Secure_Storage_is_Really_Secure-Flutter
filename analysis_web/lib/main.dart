import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:analysis_web/routes/app_routes.dart';
import 'package:analysis_web/screens/home_screen.dart';
import 'package:analysis_web/screens/auth_screen.dart';
import 'package:analysis_web/helpers/colored_logs.dart';
import 'package:analysis_web/err/general_exception.dart';
import 'package:analysis_web/notifiers/auth_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:analysis_web/controllers/auth_controller.dart';
import 'package:analysis_web/controllers/home_controller.dart';
import 'package:analysis_web/screens/auth_or_home_screen.dart';
import 'package:analysis_web/components/dialog/error_dialog.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await initLocalStorage();

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);

        _showErrorDialog(details.exception);
      };

      runApp(const MyApp());
    },
    (error, stack) => _showErrorDialog(error),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthNotifier(),
        ),
        Provider<HomeController>(
          create: (context) => HomeController(),
        ),
        Provider<AuthController>(
          create: (context) => AuthController(
            authNotifier: context.read<AuthNotifier>(),
            homeController: context.read<HomeController>(),
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: "'Login' App",
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'),
          Locale('pt', 'BR'),
        ],
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.green.shade900,
            onPrimaryFixedVariant: Colors.blue.shade900,
            secondary: Colors.red.shade600,
            onSecondaryFixedVariant: Colors.cyan,
            tertiary: Colors.white,
            onTertiaryFixedVariant: Colors.green,
            outline: Colors.grey,
            shadow: Colors.black26,
          ),
          textTheme: theme.textTheme.copyWith(
            titleLarge: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            titleMedium: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: Colors.green.shade900,
            centerTitle: true,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              backgroundColor: Colors.green.shade900,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.authOrHome: (_) => const AuthOrHomeScreen(),
          AppRoutes.home: (_) => const HomeScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) {
              return const AuthScreen();
            },
          );
        },
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final ColoredLogs logs = ColoredLogs();

void _showErrorDialog(Object error) {
  final BuildContext? context = navigatorKey.currentState?.overlay?.context;

  if (context == null) {
    return;
  }

  String title = AppLocalizations.of(context)!.errorOccurred;
  String message = error.toString();

  if (error is GeneralException) {
    title = error.title;
    message = error.message;
  }

  showDialog(
    context: context,
    builder: (ctx) => ErrorDialog(
      title: title,
      message: message,
    ),
  );
}
