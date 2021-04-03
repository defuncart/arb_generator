// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null, 'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;
 
      return instance;
    });
  } 

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null, 'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Hello world!`
  String get myKey {
    return Intl.message(
      'Hello world!',
      name: 'myKey',
      desc: 'The conventional newborn programmer greeting',
      args: [],
    );
  }

  /// `Welcome {firstName}!`
  String welcome(Object firstName) {
    return Intl.message(
      'Welcome $firstName!',
      name: 'welcome',
      desc: 'A welcome message',
      args: [firstName],
    );
  }

  /// `{count, plural, zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}}`
  String numberMessages(num count) {
    return Intl.plural(
      count,
      zero: 'You have no new messages',
      one: 'You have 1 new message',
      other: 'You have $count new messages',
      name: 'numberMessages',
      desc: 'An info message about new messages count',
      args: [count],
    );
  }

  /// `{sex, select, male{His book} female{Her book} other{Their book}}`
  String whoseBook(String sex) {
    return Intl.gender(
      sex,
      male: 'His book',
      female: 'Her book',
      other: 'Their book',
      name: 'whoseBook',
      desc: 'A message determine whose book it is',
      args: [sex],
    );
  }

  /// `{howMany, plural, zero{There are no unread emails for {userName}} one{There is 1 unread email for {userName}} other{There are {howMany} unread emails for {userName}}}`
  String unreadEmails(num howMany, Object userName) {
    return Intl.plural(
      howMany,
      zero: 'There are no unread emails for $userName',
      one: 'There is 1 unread email for $userName',
      other: 'There are $howMany unread emails for $userName',
      name: 'unreadEmails',
      desc: 'How many unread emails for user',
      args: [howMany, userName],
    );
  }

  /// `{weatherType, select, sunny{Woohoo} cloudy{Meh} rainy{Weeh} other{Other}}`
  String weatherReaction(Object weatherType) {
    return Intl.select(
      weatherType,
      {
        'sunny': 'Woohoo',
        'cloudy': 'Meh',
        'rainy': 'Weeh',
        'other': 'Other',
      },
      name: 'weatherReaction',
      desc: 'Reaction to types of weather',
      args: [weatherType],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}