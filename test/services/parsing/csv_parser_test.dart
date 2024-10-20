import 'dart:io';

import 'package:arb_generator/src/services/parsing/csv_parser.dart';
import 'package:test/test.dart';

void main() {
  test('parseFile', () {
    final parser = CSVParser(
      file: File('example/assets_dev/test.csv'),
      startIndex: 2,
      fieldDelimiter: ';',
    );
    expect(parser.supportedLanguages, ['en', 'de']);
    expect(parser.localizationsTable.map((row) => row.raw), [
      [
        'myKey',
        'The conventional newborn programmer greeting',
        'Hello world!',
        'Hallo Welt!',
      ],
      [
        'welcome',
        'A welcome message',
        'Welcome {firstName}!',
        'Willkommen {firstName}!',
      ],
      [
        'numberMessages',
        'An info message about new messages count',
        '{count, plural, zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}}',
        '{count, plural, zero{Du hast keine neue Nachrichten} one{Du hast eine neue Nachricht} other{Du hast {count} neue Nachrichten}}'
      ],
      [
        'whoseBook',
        'A message determine whose book it is',
        '{sex, select, male{His book} female{Her book} other{Their book}}',
        '{sex, select, male{Sein Buch} female{Ihr Buch} other{Ihr Buch}}'
      ],
      [
        'unreadEmails',
        'How many unread emails for user',
        '{howMany, plural, zero{There are no unread emails for {userName}} one{There is 1 unread email for {userName}} other{There are {howMany} unread emails for {userName}}}',
        '{howMany, plural, zero{Es gibt keine ungelesenen Emails für {userName}} one{Es gibt eine ungelesene für {userName}} other{Es gibt {howMany} ungelesenen Emails für {userName}}}'
      ],
      [
        'weatherReaction',
        'Reaction to types of weather',
        '{weatherType, select, sunny{Woohoo} cloudy{Meh} rainy{Weeh} other{Other}}',
        '{weatherType, select, sunny{Prima} cloudy{In Ordnung} rainy{Mist} other{Other}}'
      ],
    ]);
  });
}
