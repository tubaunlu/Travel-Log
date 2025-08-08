import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_log/screens/learnmore_screen.dart';
import 'package:travel_log/screens/signin_screen.dart';
import 'package:travel_log/widgets/language_manager.dart';
import 'package:travel_log/widgets/language_selector.dart';
import 'package:provider/provider.dart'; 


class WelcomeScreen extends StatelessWidget {
  final void Function(String code) onLocaleChange;
  
  const WelcomeScreen({super.key, required this.onLocaleChange});

  static const _titleColor = Color(0xFF111418);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Row(
                      children: [
                        const SizedBox(width: 130), 
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft, 
                            child: Consumer<LanguageManager>(
                              builder: (context, languageManager, child) {
                                return Text(
                                  languageManager.getText('app_name'), 
                                  style: GoogleFonts.splineSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: WelcomeScreen._titleColor,
                                    letterSpacing: -0.2,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.language_rounded, size: 24),
                          color: WelcomeScreen._titleColor,
                          tooltip: 'Change language',
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                            ),
                            builder: (_) {
                              return LanguageSelector(onLocaleChange: onLocaleChange); 
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: height * 0.35,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAeNPjZTS8yonkzBX6YwPhI8HO2G0HUaR0_Gqays4Hnw6ho3ljtjujrMmRLKdnKZAYEU6VeD7oGc6qBTzpJnA1lnJgL6bznjlexUOjQ6Tal5Vbqly83PKX9qmwRw8eX9reueOaoKjNv4xWwsSChKxdIHSE7Fw0mliJwUq5Fa8q7MiHNs13PV91gCy1DyJ4l0x29AV2KyCeY_HZTlw_5qyTVB8Id43swAu1XI0-F5dNjqlFXfO1IwxZ0wcX3z6wbaKa0SzAUQliPT74Y',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Consumer<LanguageManager>(
                      builder: (context, languageManager, child) {
                        return Text(
                          languageManager.getText('welcome_message'),  
                          textAlign: TextAlign.center,
                          style: GoogleFonts.splineSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: WelcomeScreen._titleColor,
                            letterSpacing: -0.2,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Consumer<LanguageManager>(
                      builder: (context, languageManager, child) {
                        return Text(
                          languageManager.getText('explore_description'), 
                          textAlign: TextAlign.center,
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: WelcomeScreen._titleColor,
                            height: 1.35,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFF0b79ee),
                          shape: RoundedRectangleBorder(    
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Consumer<LanguageManager>(
                          builder: (context, languageManager, child) {
                            return Text(
                              languageManager.getText('start_exploring'), 
                              style: GoogleFonts.splineSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LearnmoreScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Color.fromARGB(255, 206, 214, 223),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Consumer<LanguageManager>(
                          builder: (context, languageManager, child) {
                            return Text(
                              languageManager.getText('learn_more'), 
                              style: GoogleFonts.splineSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                letterSpacing: 1.2,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
