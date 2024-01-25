import 'app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn(super.locale);


  @override
  String translate(String key) {
    switch (key) {
      case 'Chat Screen':
        return 'Chat Screen';
      case 'good_morning':
        return 'Good Morning';
    // Add more translations here
      default:
        return super.translate(key);
    }
  }
}