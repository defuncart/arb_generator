import 'dart:io';

import 'package:flappy_translator/src/services/parsing/csv_parser.dart';
import 'package:flappy_translator/src/services/validation/validator.dart';

import '../models/package_settings.dart';

/// A service which generates arb files
abstract class ARBGenerator {
  /// Generates an output arb file
  static void generate(
    PackageSettings packageSettings,
  ) {
    // check that the file exists
    final file = File(packageSettings.inputFilepath);
    Validator.validateFile(file);

    // File is valid, state progress
    print('Loading file ${packageSettings.inputFilepath}...');

    final parser = CSVParser(
      file: file,
      startIndex: packageSettings.csvSettings.columnIndex,
      fieldDelimiter: packageSettings.csvSettings.delimiter,
    );

    final supportedLanguages = parser.supportedLanguages;
    Validator.validateSupportedLanguages(supportedLanguages);

    print('Locales $supportedLanguages determined.');

    final localizationsTable = parser.localizationsTable;
    print('Parsing ${localizationsTable.length} key(s)...');

    for (final row in localizationsTable) {
      Validator.validateLocalizationTableRow(
        row,
        numberSupportedLanguages: supportedLanguages.length,
      );
    }

    // TODO generate ARB
  }
}
