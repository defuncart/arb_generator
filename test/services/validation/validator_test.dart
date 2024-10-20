import 'dart:io';

import 'package:arb_generator/arb_generator.dart';
import 'package:arb_generator/src/services/parsing/file_parser.dart';
import 'package:arb_generator/src/services/validation/validator.dart';
import 'package:test/test.dart';

import '../../extensions/temp_file_handler.dart';

void main() {
  group('validateCSVSettings', () {
    group('validateFile', () {
      test('file does not exist', () {
        Validator.validateFile(File('bla.csv'));
      });

      test('file not valid extension', () {
        tempFileHandler('test.txt', (file) {
          Validator.validateFile(file);
        });
      });
    });

    group('validateSupportedLanguages', () {
      test('locale is not valid', () {
        Validator.validateSupportedLanguages(['a']);
      });

      test('locale is not supported by default', () {
        Validator.validateSupportedLanguages(['ga']);
      });
    });

    group('validateLocalizationsTable', () {
      test('localization table is empty', () {
        Validator.validateLocalizationsTable([]);
      });
    });

    group('validateLocalizationTableRow', () {
      test('key is reserved word', () {
        Validator.validateLocalizationTableRow(
          LocalizationTableRow(
            key: 'for',
            defaultWord: 'a',
            words: ['a'],
            raw: ['for', 'a'],
          ),
          numberSupportedLanguages: 1,
        );
      });

      test('key is type', () {
        Validator.validateLocalizationTableRow(
          LocalizationTableRow(
            key: 'int',
            defaultWord: 'a',
            words: ['a'],
            raw: ['int', 'a'],
          ),
          numberSupportedLanguages: 1,
        );
      });

      test('key is not valid variable name', () {
        Validator.validateLocalizationTableRow(
          LocalizationTableRow(
            key: 'MyKey',
            defaultWord: 'a',
            words: ['a'],
            raw: ['MyKey', 'a'],
          ),
          numberSupportedLanguages: 1,
        );
      });

      test('key is not valid variable name', () {
        Validator.validateLocalizationTableRow(
          LocalizationTableRow(
            key: 'MyKey',
            defaultWord: 'a',
            words: ['a', 'b'],
            raw: ['MyKey', 'a', 'b'],
          ),
          numberSupportedLanguages: 1,
        );
      });

      test('key is not valid variable name', () {
        Validator.validateLocalizationTableRow(
          LocalizationTableRow(
            key: 'MyKey',
            defaultWord: '',
            words: ['', 'b'],
            raw: ['MyKey', '', 'b'],
          ),
          numberSupportedLanguages: 2,
        );
      });
    });

    test('Valid settings delimiter, baseIndex expect true', () {
      const csvSettings = CSVSettings(
        delimiter: ',',
        baseIndex: 1,
      );
      expect(Validator.validateCSVSettings(csvSettings), isTrue);
    });

    test('Valid settings all expect true', () {
      const csvSettings = CSVSettings(
        delimiter: ',',
        baseIndex: 2,
        descriptionIndex: 1,
      );
      expect(Validator.validateCSVSettings(csvSettings), isTrue);
    });

    test('baseIndex < 1 expect false', () {
      const csvSettings = CSVSettings(
        delimiter: ',',
        baseIndex: 0,
      );
      expect(Validator.validateCSVSettings(csvSettings), isFalse);
    });

    test('descriptionIndex < 1 expect false', () {
      const csvSettings = CSVSettings(
        delimiter: ',',
        baseIndex: 1,
        descriptionIndex: 0,
      );
      expect(Validator.validateCSVSettings(csvSettings), isFalse);
    });

    test('descriptionIndex >= baseIndex expect false', () {
      const csvSettings = CSVSettings(
        delimiter: ',',
        baseIndex: 0,
        descriptionIndex: 1,
      );
      expect(Validator.validateCSVSettings(csvSettings), isFalse);
    });
  });

  group('validateFile', () {
    test('file does not exist', () {
      Validator.validateFile(File('bla.csv'));
    });

    test('file not valid extension', () {
      tempFileHandler('test.txt', (file) {
        Validator.validateFile(file);
      });
    });
  });

  group('validateSupportedLanguages', () {
    test('locale is not valid', () {
      Validator.validateSupportedLanguages(['a']);
    });

    test('locale is not supported by default', () {
      Validator.validateSupportedLanguages(['ga']);
    });
  });

  group('validateLocalizationsTable', () {
    test('localization table is empty', () {
      Validator.validateLocalizationsTable([]);
    });
  });

  group('validateLocalizationTableRow', () {
    test('key is reserved word', () {
      Validator.validateLocalizationTableRow(
        LocalizationTableRow(
          key: 'for',
          defaultWord: 'a',
          words: ['a'],
          raw: ['for', 'a'],
        ),
        numberSupportedLanguages: 1,
      );
    });

    test('key is type', () {
      Validator.validateLocalizationTableRow(
        LocalizationTableRow(
          key: 'int',
          defaultWord: 'a',
          words: ['a'],
          raw: ['int', 'a'],
        ),
        numberSupportedLanguages: 1,
      );
    });

    test('key is not valid variable name', () {
      Validator.validateLocalizationTableRow(
        LocalizationTableRow(
          key: 'MyKey',
          defaultWord: 'a',
          words: ['a'],
          raw: ['MyKey', 'a'],
        ),
        numberSupportedLanguages: 1,
      );
    });

    test('key is not valid variable name', () {
      Validator.validateLocalizationTableRow(
        LocalizationTableRow(
          key: 'MyKey',
          defaultWord: 'a',
          words: ['a', 'b'],
          raw: ['MyKey', 'a', 'b'],
        ),
        numberSupportedLanguages: 1,
      );
    });

    test('key is not valid variable name', () {
      Validator.validateLocalizationTableRow(
        LocalizationTableRow(
          key: 'MyKey',
          defaultWord: '',
          words: ['', 'b'],
          raw: ['MyKey', '', 'b'],
        ),
        numberSupportedLanguages: 2,
      );
    });
  });
}
