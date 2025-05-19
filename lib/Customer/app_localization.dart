import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'clothing': 'Clothing',
      'electronics': 'Electronics',
      'footwear': 'Footwear',
      'accessories': 'Accessories',
      'home_appliances': 'Home Appliances',
      'books': 'Books',
      'others': 'Others',
      'brands': 'Brands',
      'see_all': 'See All',
      'profile': 'Profile',
      'orders_history': 'Orders History',
      'privacy_policies': 'Privacy and Policies',
      'terms_conditions': 'Terms & Conditions',
      'about_us': 'About Us',
      'shipping_policy': 'Shipping Policy',
      'change_theme': 'Change Theme',
      'language': 'Language',
    },
    'hi': {
      'clothing': 'कपड़े',
      'electronics': 'इलेक्ट्रॉनिक्स',
      'footwear': 'जूते',
      'accessories': 'सहायक उपकरण',
      'home_appliances': 'घरेलू उपकरण',
      'books': 'किताबें',
      'others': 'अन्य',
      'brands': 'ब्रांड्स',
      'see_all': 'सभी देखें',
      'profile': 'प्रोफ़ाइल',
      'orders_history': 'आदेश इतिहास',
      'privacy_policies': 'गोपनीयता नीति',
      'terms_conditions': 'नियम एवं शर्तें',
      'about_us': 'हमारे बारे में',
      'shipping_policy': 'शिपिंग नीति',
      'change_theme': 'थीम बदलें',
      'language': 'भाषा',
    },
    'kn': {
      'clothing': 'ಉಡುಪು',
      'electronics': 'ಎಲೆಕ್ಟ್ರಾನಿಕ್ಸ್',
      'footwear': 'ಪಾದರಕ್ಷೆ',
      'accessories': 'ಆಕ್ಸೆಸರಿಗಳು',
      'home_appliances': 'ಮನೆ ಉಪಕರಣಗಳು',
      'books': 'ಪುಸ್ತಕಗಳು',
      'others': 'ಇತರೆ',
      'brands': 'ಬ್ರಾಂಡ್ಗಳು',
      'see_all': 'ಎಲ್ಲಾ ನೋಡಿ',
      'profile': 'ಪ್ರೊಫೈಲ್',
      'orders_history': 'ಆರ್ಡರ್ ಇತಿಹಾಸ',
      'privacy_policies': 'ಗೌಪ್ಯತೆ ನೀತಿ',
      'terms_conditions': 'ನಿಯಮಗಳು ಮತ್ತು ಷರತ್ತುಗಳು',
      'about_us': 'ನಮ್ಮ ಬಗ್ಗೆ',
      'shipping_policy': 'ಶಿಪ್ಪಿಂಗ್ ನೀತಿ',
      'change_theme': 'ಥೀಮ್ ಬದಲಾಯಿಸಿ',
      'language': 'ಭಾಷೆ',
    },
    'te': {
      'clothing': 'దుస్తులు',
      'electronics': 'ఎలక్ట్రానిక్స్',
      'footwear': 'పాదరక్షలు',
      'accessories': 'ఆక్సెసరీస్',
      'home_appliances': 'హోమ్ ఉపకరణాలు',
      'books': 'పుస్తకాలు',
      'others': 'ఇతరులు',
      'brands': 'బ్రాండ్లు',
      'see_all': 'అన్ని చూడండి',
      'profile': 'ప్రొఫైల్',
      'orders_history': 'ఆర్డర్ చరిత్ర',
      'privacy_policies': 'గోప్యతా విధానం',
      'terms_conditions': 'నిబంధనలు మరియు షరతులు',
      'about_us': 'మా గురించి',
      'shipping_policy': 'షిప్పింగ్ పాలసీ',
      'change_theme': 'థీమ్ మార్చు',
      'language': 'భాష',
    },
  };

  String? get profile => _localizedValues[locale.languageCode]?['profile'];
  String? get ordersHistory => _localizedValues[locale.languageCode]?['orders_history'];
  String? get privacyPolicies => _localizedValues[locale.languageCode]?['privacy_policies'];
  String? get termsConditions => _localizedValues[locale.languageCode]?['terms_conditions'];
  String? get aboutUs => _localizedValues[locale.languageCode]?['about_us'];
  String? get shippingPolicy => _localizedValues[locale.languageCode]?['shipping_policy'];
  String? get changeTheme => _localizedValues[locale.languageCode]?['change_theme'];
  String? get language => _localizedValues[locale.languageCode]?['language'];
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi', 'kn', 'te'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}