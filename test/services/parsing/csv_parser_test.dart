import 'dart:io';

import 'package:arb_generator/src/services/parsing/csv_parser.dart';
import 'package:arb_generator/src/services/parsing/file_parser.dart';
import 'package:test/test.dart';

void main() {
  test('parseFile', () {
    final parser = CSVParser(
      file: File('example/assets_dev/test.csv'),
      startIndex: 2,
      fieldDelimiter: ';',
    );
    final table = parser.parse(descriptionIndex: 1);
    expect(table.supportedLanguages, ['en', 'de']);
    expect(table.rows, [
      LocalizationTableRow(
        key: 'myKey',
        description: 'The conventional newborn programmer greeting',
        values: {
          'en': 'Hello world!',
          'de': 'Hallo Welt!',
        },
      ),
      LocalizationTableRow(
        key: 'welcome',
        description: 'A welcome message',
        values: {
          'en': 'Welcome {firstName}!',
          'de': 'Willkommen {firstName}!',
        },
      ),
      LocalizationTableRow(
        key: 'numberMessages',
        description: 'An info message about new messages count',
        values: {
          'en':
              '{count, plural, zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}}',

          'de':
              '{count, plural, zero{Du hast keine neue Nachrichten} one{Du hast eine neue Nachricht} other{Du hast {count} neue Nachrichten}}',
        },
      ),

      LocalizationTableRow(
        key: 'whoseBook',
        description: 'A message determining whose book it is',
        values: {
          'en':
              '{sex, select, male{His book} female{Her book} other{Their book}}',
          'de':
              '{sex, select, male{Sein Buch} female{Ihr Buch} other{Ihr Buch}}',
        },
      ),

      LocalizationTableRow(
        key: 'unreadEmails',
        description: 'How many unread emails for user',
        values: {
          'en':
              '{howMany, plural, zero{There are no unread emails for {userName}} one{There is 1 unread email for {userName}} other{There are {howMany} unread emails for {userName}}}',
          'de':
              '{howMany, plural, zero{Es gibt keine ungelesenen Emails für {userName}} one{Es gibt eine ungelesene für {userName}} other{Es gibt {howMany} ungelesenen Emails für {userName}}}',
        },
      ),
      LocalizationTableRow(
        key: 'weatherReaction',
        description: 'Reaction to types of weather',
        values: {
          'en':
              '{weatherType, select, sunny{Woohoo} cloudy{Meh} rainy{Weeh} other{Other}}',
          'de':
              '{weatherType, select, sunny{Prima} cloudy{In Ordnung} rainy{Mist} other{Other}}',
        },
      ),
    ]);
  });
}
