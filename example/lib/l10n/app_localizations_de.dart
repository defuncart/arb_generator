// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get myKey => 'Hallo Welt!';

  @override
  String welcome(Object firstName) {
    return 'Willkommen $firstName!';
  }

  @override
  String numberMessages(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Du hast $count neue Nachrichten',
      one: 'Du hast eine neue Nachricht',
      zero: 'Du hast keine neue Nachrichten',
    );
    return '$_temp0';
  }

  @override
  String whoseBook(String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'Sein Buch',
        'female': 'Ihr Buch',
        'other': 'Ihr Buch',
      },
    );
    return '$_temp0';
  }

  @override
  String unreadEmails(num howMany, Object userName) {
    String _temp0 = intl.Intl.pluralLogic(
      howMany,
      locale: localeName,
      other: 'Es gibt $howMany ungelesenen Emails für $userName',
      one: 'Es gibt eine ungelesene für $userName',
      zero: 'Es gibt keine ungelesenen Emails für $userName',
    );
    return '$_temp0';
  }

  @override
  String weatherReaction(String weatherType) {
    String _temp0 = intl.Intl.selectLogic(
      weatherType,
      {
        'sunny': 'Prima',
        'cloudy': 'In Ordnung',
        'rainy': 'Mist',
        'other': 'Other',
      },
    );
    return '$_temp0';
  }
}
