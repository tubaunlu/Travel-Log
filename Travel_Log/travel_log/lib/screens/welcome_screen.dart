import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.onLocaleChange});

  final void Function(String code) onLocaleChange;

  
  static const _titleColor = Color(0xFF111418);
  // ignore: unused_field
  static const _primaryBlue = Color(0xFF0B79EE);
  // ignore: unused_field
  static const _surfaceGray = Color(0xFFF0F2F5);

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
                        Expanded(
                          child: Center(
                            child: Text(
                              'Wanderlust',
                              style: GoogleFonts.splineSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: _titleColor,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.language_rounded, size: 24),
                          color: _titleColor,
                          tooltip: 'Change language',
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                            ),
                            builder: (_) => LanguageSelector(onLocaleChange: onLocaleChange),
                          ),
                        ),
                      ],
                    ),
                  ),

            
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

      
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Welcome to Wanderlust',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.splineSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: _titleColor,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),

              
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Text(
                      'Explore the world, one adventure at a time. '
                      'Track your journeys, discover new places, and share your experiences with fellow travelers.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        color: _titleColor,
                        height: 1.35,
                      ),
                    ),
                  ),

        
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _PrimaryButton(
                          label: 'Start Exploring',
                          onPressed: () {/* TODO */},
                        ),
                        const SizedBox(height: 12),
                        _SecondaryButton(
                          label: 'Learn More',
                          onPressed: () {/* TODO */},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

      
          _BottomNavBar(currentIndex: 0, onTap: (i) {/* TODO */}),
        ],
      ),
    );
  }
  
  // ignore: non_constant_identifier_names
  _SecondaryButton({required String label, required Null Function() onPressed}) {}
  
  // ignore: non_constant_identifier_names
  _BottomNavBar({required int currentIndex, required Null Function(dynamic i) onTap}) {}
  
  // ignore: non_constant_identifier_names
  _PrimaryButton({required String label, required Null Function() onPressed}) {}
}


class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key, required this.onLocaleChange});

  final void Function(String code) onLocaleChange;

  @override
  Widget build(BuildContext context) {
    Widget dragHandle() => Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.only(top: 12, bottom: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
          ),
        );

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          dragHandle(),
          _langTile(context, code: 'en', label: 'English', flag: '🇺🇸'),
          _langTile(context, code: 'tr', label: 'Türkçe', flag: '🇹🇷'),
          _langTile(context, code: 'de', label: 'Deutsch', flag: '🇩🇪'),
          _langTile(context, code: 'ru', label: 'Русский', flag: '🇷🇺'),
          _langTile(context, code: 'es', label: 'Español', flag: '🇪🇸'),
          _langTile(context, code: 'it', label: 'Italiano', flag: '🇮🇹'),
          _langTile(context, code: 'fr', label: 'Français', flag: '🇫🇷'),
          _langTile(context, code: 'zh', label: '中文', flag: '🇨🇳'),
          _langTile(context, code: 'ja', label: '日本語', flag: '🇯🇵'),
          _langTile(context, code: 'ar', label: 'العربية', flag: '🇸🇦'),
          _langTile(context, code: 'ko', label: '한국어', flag: '🇰🇷'),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  ListTile _langTile(BuildContext ctx,
      {required String code, required String label, required String flag}) {
    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 20)),
      title: Text(label),
      onTap: () {
        onLocaleChange(code);
        Navigator.pop(ctx);
      },
    );
  }
}


