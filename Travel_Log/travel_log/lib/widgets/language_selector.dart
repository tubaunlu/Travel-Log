import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_log/widgets/language_manager.dart';

class LanguageSelector extends StatelessWidget {
  final void Function(String code) onLocaleChange;
  
  LanguageSelector({super.key, required this.onLocaleChange});

  final List<Map<String, String>> languages = [
    {'code': 'tr', 'label': '🇹🇷 Türkçe'},
    {'code': 'en', 'label': '🇬🇧 English'},
    {'code': 'de', 'label': '🇩🇪 Deutsch'},
    {'code': 'ru', 'label': '🇷🇺 Русский'},
    {'code': 'fr', 'label': '🇫🇷 Français'},
    {'code': 'es', 'label': '🇪🇸 Español'},
    {'code': 'ar', 'label': '🇸🇦 العربية'},
    {'code': 'zh', 'label': '🇨🇳 中文'},
    {'code': 'ja', 'label': '🇯🇵 日本語'},
    {'code': 'ko', 'label': '🇰🇷 한국어'},
    {'code': 'pt', 'label': '🇵🇹 Português'},
    {'code': 'it', 'label': '🇮🇹 Italiano'},
    {'code': 'hi', 'label': '🇮🇳 हिंदी'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
            Provider.of<LanguageManager>(context, listen: false).changeLocale(languages[index]['code']!);
            Navigator.of(context).pop();  
          },
          title: Text(languages[index]['label']!),
        );
      },
      ),
    );
  }
}
