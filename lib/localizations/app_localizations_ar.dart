import 'app_localizations.dart';

class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr(super.locale);

  @override
  String translate(String key) {
    switch (key) {
      case 'hello':
        return 'مرحبًا';
      case 'good_morning':
        return 'صباح الخير';
    // Add more translations here
      default:
        return '';
    }
  }
}