import 'dart:io';

import 'package:flappy_translator/src/services/file_writer/file_writer.dart';
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

    for (final supportedLanguage in supportedLanguages) {
      final content = _generateARBFile(
        langauge: supportedLanguage,
        keys: parser.keys,
        values: parser.getValues(supportedLanguage),
        defaultValues: parser.defaultValues,
      );

      // write output file
      final path = '${packageSettings.outputDirectory}/${packageSettings.filenamePrepend}$supportedLanguage.arb';
      print(path);
      FileWriter().write(contents: content, path: path);
    }
  }
}

String _generateARBFile({
  required String langauge,
  required List<String> keys,
  required List<String> values,
  required List<String> defaultValues,
}) {
  if (keys.length != values.length && keys.length != defaultValues.length) {
    print('Error! Mismatch number of keys and values');
    exit(0);
  }

  final sb = StringBuffer();
  sb.writeln('{');
  sb.writeln('\t\"@@locale\": \"$langauge\",');
  for (var i = 0; i < keys.length; i++) {
    final value = i < values.length && values[i].isNotEmpty ? values[i] : defaultValues[i];
    sb.write('\t\"${keys[i]}": \"$value\"');
    if (i != keys.length - 1) {
      sb.write(',');
    }
    sb.writeln();
  }
  sb.writeln('}');

  return sb.toString();
}
