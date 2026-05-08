import 'dart:io';

import 'package:arb_generator/src/services/parsing/file_parser.dart';
import 'package:test/test.dart';

import '../../testing_utils.dart';

void main() {
  late FileParser parser;

  setUp(
    () => parser = _MockFileParser(
      file: File('example/test.csv'),
      startIndex: 1,
    ),
  );

  test('Parameter startIndex <= 0 triggers assertion', () {
    expect(
      () => _MockFileParser(file: File('example/test.csv'), startIndex: 0),
      throwsAssertionError,
    );
  });

  test('parse', () {
    expect(
      parser.parse(),
      LocalizationTable(
        supportedLanguages: ['en', 'de'],
        rows: [
          LocalizationTableRow(
            key: 'test',
            description: null,
            values: {
              'en': 'Hello, World!',
              'de': 'Hallo, Welt!',
            },
          ),
        ],
      ),
    );
  });
}

class _MockFileParser extends FileParser {
  _MockFileParser({
    required File file,
    required int startIndex,
  }) : super(file: file, startIndex: startIndex);

  @override
  List<List<String>> parseFile() => [
    [
      'key',
      'en',
      'de',
    ],
    [
      'test',
      'Hello, World!',
      'Hallo, Welt!',
    ],
  ];
}
