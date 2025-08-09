import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';  
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_log/screens/welcome_screen.dart';
import 'package:travel_log/screens/home_screen.dart';   
import 'package:travel_log/screens/settings_screen.dart'; 
import 'package:travel_log/screens/map_screen.dart';    
import 'package:travel_log/screens/create_screen.dart';  
import 'package:travel_log/widgets/language_manager.dart';
import 'firebase_options.dart';  

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,  
    );
  } catch (e) {
    if (kDebugMode) {
      print('Error initializing Firebase: $e');  
    }
  }

  runApp(MyApp(localeCode: 'en')); 
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required String localeCode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageManager>(
      create: (_) => LanguageManager(),
      child: Consumer<LanguageManager>(
        builder: (context, languageManager, child) {
          return MaterialApp(
            title: 'Travel Log',
            debugShowCheckedModeBanner: false,
            locale: languageManager.locale,
            supportedLocales: [
              Locale('en', ''),
              Locale('tr', ''),
              Locale('de', ''),
              Locale('ru', ''),
              Locale('fr', ''),
              Locale('es', ''),
              Locale('ar', ''),
              Locale('zh', ''),
              Locale('ja', ''),
              Locale('ko', ''),
              Locale('pt', ''),
              Locale('it', ''),
              Locale('hi', ''),
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: '/',  
            routes: {
              '/': (context) => WelcomeScreen(
                    onLocaleChange: (code) {
                      languageManager.changeLocale(code);  
                    },
                  ),
              '/home': (context) => HomeScreen(),
              '/settings': (context) => SettingsScreen(),
              '/map': (context) => MapScreen(title: '',),
              '/create': (context) => CreateScreen(address: '',),
            },
          );
        },
      ),
    );
  }
}
