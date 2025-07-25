import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:student_attending/config/app_routes.dart';
import 'package:student_attending/config/app_theme.dart';
import 'package:student_attending/providers/assistant_provider.dart';
import 'package:student_attending/providers/center_provider.dart';
import 'package:student_attending/providers/group_provider.dart';
import 'package:student_attending/providers/lesson_provider.dart';
import 'package:student_attending/providers/student_provider.dart';
import 'package:student_attending/utils/common_utils.dart';
import 'package:student_attending/views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String language = await CommonUtils.getCurrentLang();
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: language,
    supportedLocales: ['en', 'ar'],
  );

  runApp(
    LocalizedApp(
      delegate,
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GroupProvider()),
          ChangeNotifierProvider(create: (_) => AssistantProvider()),
          ChangeNotifierProvider(create: (_) => CenterProvider()),
          ChangeNotifierProvider(create: (_) => StudentProvider()),
          ChangeNotifierProvider(create: (_) => LessonProvider()),
        ],
        child: StudentApp(),
      ),
    ),
  );
}

class StudentApp extends StatefulWidget {
  const StudentApp({super.key});

  @override
  State<StudentApp> createState() => _StudentAppState();
}

class _StudentAppState extends State<StudentApp> {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: translate("student_attending"),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          localizationDelegate,
        ],
        locale: localizationDelegate.currentLocale,
        supportedLocales: localizationDelegate.supportedLocales,
        theme: AppTheme.light,
        home: SplashScreen(),
        routes: appRoutes,
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
