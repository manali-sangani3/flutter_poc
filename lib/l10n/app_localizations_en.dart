// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Accessibility Demo';

  @override
  String get description =>
      'This screen demonstrates accessibility and localization support.';

  @override
  String get themeText => 'Dark Theme';

  @override
  String get languageText => 'Arabic Language';

  @override
  String get buttonText => 'Continue';

  @override
  String hello(String userName) {
    return 'Hello $userName';
  }
}
