// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get title => 'عرض إمكانية الوصول';

  @override
  String get description => 'توضح هذه الشاشة دعم إمكانية الوصول والترجمة.';

  @override
  String get themeText => 'الوضع الداكن';

  @override
  String get languageText => 'اللغة الإنجليزية';

  @override
  String get buttonText => 'متابعة';

  @override
  String hello(String userName) {
    return 'مرحبًا $userName';
  }
}
