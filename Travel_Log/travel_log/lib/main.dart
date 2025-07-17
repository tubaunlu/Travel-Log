import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_log/firebase_options.dart';
import 'package:travel_log/screens/welcome_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final savedLocale = prefs.getString('locale') ?? 'en';

  runApp(MyApp(localeCode: savedLocale));
}

class SharedPreferences {
  static Future getInstance() async {}
}

class MyApp extends StatefulWidget {
  final String localeCode;
  const MyApp({super.key, required this.localeCode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.localeCode);
  }

  void _changeLocale(String code) async {
    // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
    var SharedPreferences;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', code);

    setState(() {
      _locale = Locale(code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Log',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        Locale('de'),
        Locale('ru'),
        Locale('es'),
        Locale('fr'),
        Locale('it'),
        Locale('zh'),
        Locale('ja'),
        Locale('ar'),
        Locale('ko'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: WelcomeScreen(onLocaleChange: _changeLocale),
    );
  }
}

