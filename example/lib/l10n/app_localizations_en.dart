// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get myKey => 'Hello world!';

  @override
  String welcome(String firstName) {
    return 'Welcome $firstName!';
  }

  @override
  String numberMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You have $count new messages',
      one: 'You have 1 new message',
      zero: 'You have no new messages',
    );
    return '$_temp0';
  }

  @override
  String whoseBook(String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'His book',
        'female': 'Her book',
        'other': 'Their book',
      },
    );
    return '$_temp0';
  }

  @override
  String unreadEmails(int howMany, String userName) {
    String _temp0 = intl.Intl.pluralLogic(
      howMany,
      locale: localeName,
      other: 'There are $howMany unread emails for $userName',
      one: 'There is 1 unread email for $userName',
      zero: 'There are no unread emails for $userName',
    );
    return '$_temp0';
  }

  @override
  String weatherReaction(String weatherType) {
    String _temp0 = intl.Intl.selectLogic(
      weatherType,
      {
        'sunny': 'Woohoo',
        'cloudy': 'Meh',
        'rainy': 'Weeh',
        'other': 'Other',
      },
    );
    return '$_temp0';
  }
}
