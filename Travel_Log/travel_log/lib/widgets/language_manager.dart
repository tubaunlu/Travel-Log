import 'package:flutter/material.dart';

class LanguageManager with ChangeNotifier {
  Locale _locale = Locale('en');

  final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'app_name': 'Travel Log',
      'welcome_message': 'Welcome to Travel Log',
      'explore_description': 'Explore the world, one adventure at a time. Track your journeys, discover new places, and share your experiences with fellow travelers.',
      'start_exploring': 'Start Exploring',
      'learn_more': 'Learn More',
    },
    'tr': {
      'app_name': 'Travel Log',
      'welcome_message': 'Travel Log\'a Hoşgeldiniz',
      'explore_description': 'Dünyayı keşfedin, her macerayla. Seyahatlerinizi takip edin, yeni yerler keşfedin ve deneyimlerinizi diğer gezginlerle paylaşın.',
      'start_exploring': 'Keşfetmeye Başla',
      'learn_more': 'Daha Fazla Bilgi',
    },
    'ar': {
      'app_name': 'سجل السفر',
      'welcome_message': 'مرحبًا بكم في سجل السفر',
      'explore_description': 'استكشف العالم، مغامرة واحدة في كل مرة. تتبع رحلاتك، اكتشف أماكن جديدة، وشارك تجاربك مع مسافرين آخرين.',
      'start_exploring': 'ابدأ الاستكشاف',
      'learn_more': 'اعرف المزيد',
    },
    'hi': {
      'app_name': 'यात्रा लॉग',
      'welcome_message': 'यात्रा लॉग में आपका स्वागत है',
      'explore_description': 'दुनिया का अन्वेषण करें, एक साहसिक कार्य में एक बार। अपनी यात्राओं को ट्रैक करें, नए स्थानों की खोज करें, और अपने अनुभवों को अन्य यात्रियों के साथ साझा करें।',
      'start_exploring': 'अन्वेषण शुरू करें',
      'learn_more': 'और जानें',
    },
    'de': {
      'app_name': 'Reiseprotokoll',
      'welcome_message': 'Willkommen beim Reiseprotokoll',
      'explore_description': 'Entdecken Sie die Welt, ein Abenteuer nach dem anderen. Verfolgen Sie Ihre Reisen, entdecken Sie neue Orte und teilen Sie Ihre Erfahrungen mit anderen Reisenden.',
      'start_exploring': 'Erkunden Sie jetzt',
      'learn_more': 'Erfahren Sie mehr',
    },
    'fr': {
      'app_name': 'Journal de Voyage',
      'welcome_message': 'Bienvenue dans le Journal de Voyage',
      'explore_description': 'Explorez le monde, une aventure à la fois. Suivez vos voyages, découvrez de nouveaux endroits et partagez vos expériences avec d\'autres voyageurs.',
      'start_exploring': 'Commencer à explorer',
      'learn_more': 'En savoir plus',
    },
    'es': {
      'app_name': 'Registro de Viajes',
      'welcome_message': 'Bienvenido al Registro de Viajes',
      'explore_description': 'Explora el mundo, una aventura a la vez. Sigue tus viajes, descubre nuevos lugares y comparte tus experiencias con otros viajeros.',
      'start_exploring': 'Comienza a explorar',
      'learn_more': 'Aprende más',
    },
    'zh': {
      'app_name': '旅行日志',
      'welcome_message': '欢迎来到旅行日志',
      'explore_description': '探索世界，一次冒险。跟踪您的旅程，发现新地方，并与其他旅行者分享您的经历。',
      'start_exploring': '开始探索',
      'learn_more': '了解更多',
      
    },
    'ja': {
      'app_name': '旅行ログ',
      'welcome_message': '旅行ログへようこそ',
      'explore_description': '世界を探索し、一度に一つの冒険。旅を追跡し、新しい場所を発見し、他の旅行者と経験を共有します。',
      'start_exploring': '探索を始める',
      'learn_more': 'もっと知る',
    },
    'ko': {
      'app_name': '여행 기록',
      'welcome_message': '여행 기록에 오신 것을 환영합니다',
      'explore_description': '세상을 탐험하세요, 한 번의 모험으로. 여행을 추적하고, 새로운 장소를 발견하고, 다른 여행자들과 경험을 공유하세요.',
      'start_exploring': '탐험 시작하기',
      'learn_more': '더 알아보기',
    },
    'pt': {
      'app_name': 'Registro de Viagens',
      'welcome_message': 'Bem-vindo ao Registro de Viagens',
      'explore_description': 'Explore o mundo, uma aventura de cada vez. Acompanhe suas viagens, descubra novos lugares e compartilhe suas experiências com outros viajantes.',
      'start_exploring': 'Comece a explorar',
      'learn_more': 'Saiba mais',
    
    },
    'it': {
      'app_name': 'Registro di Viaggi',
      'welcome_message': 'Benvenuto nel Registro di Viaggi',
      'explore_description': 'Esplora il mondo, un’avventura alla volta. Traccia i tuoi viaggi, scopri nuovi luoghi e condividi le tue esperienze con altri viaggiatori.',
      'start_exploring': 'Inizia a esplorare',
      'learn_more': 'Scopri di più',
    },
    'ru': {
      'app_name': 'Журнал Путешествий',
      'welcome_message': 'Добро пожаловать в Журнал Путешествий',
      'explore_description': 'Исследуйте мир, одно приключение за раз. Отслеживайте свои путешествия, открывайте новые места и делитесь своими впечатлениями с другими путешественниками.',
      'start_exploring': 'Начать исследование',
      'learn_more': 'Узнать больше',
    },
     
  };

  Locale get locale => _locale;

  void changeLocale(String code) {
    _locale = Locale(code);
    notifyListeners();
  }

  String getText(String key) {
    return _localizedStrings[_locale.languageCode]?[key] ?? key;
  }
}
