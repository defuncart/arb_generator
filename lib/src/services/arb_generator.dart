// ignore_for_file: implementation_imports

import 'dart:convert';
import 'dart:io';

import 'package:flappy_translator/src/services/file_writer/file_writer.dart';
import 'package:flappy_translator/src/services/parsing/csv_parser.dart';
import 'package:flappy_translator/src/services/validation/validator.dart'
    as flappy;

import '../models/arb/arb_file.dart';
import '../models/settings/package_settings.dart';
import 'validation/validator.dart';

/// A service which generates arb files
abstract class ARBGenerator {
  /// Generates an output arb file
  static void generate(
    PackageSettings packageSettings,
  ) {
    // check that the file exists
    final file = File(packageSettings.inputFilepath);
    flappy.Validator.validateFile(file);

    if (!Validator.validateCSVSettings(packageSettings.csvSettings)) {
      exit(0);
    }

    // File is valid, state progress
    print('Loading file ${packageSettings.inputFilepath}...');

    final parser = CSVParser(
      file: file,
      startIndex: packageSettings.csvSettings.baseIndex,
      fieldDelimiter: packageSettings.csvSettings.delimiter,
    );

    final supportedLanguages = parser.supportedLanguages;
    flappy.Validator.validateSupportedLanguages(supportedLanguages);

    print('Locales $supportedLanguages determined.');

    final localizationsTable = parser.localizationsTable;
    print('Parsing ${localizationsTable.length} key(s)...');

    final encoder = JsonEncoder.withIndent('  ');

    for (final row in localizationsTable) {
      flappy.Validator.validateLocalizationTableRow(
        row,
        numberSupportedLanguages: supportedLanguages.length,
      );
    }

    for (final supportedLanguage in supportedLanguages) {
      final content = _generateARBFile(
        language: supportedLanguage,
        keys: parser.keys,
        values: parser.getValues(supportedLanguage),
        defaultValues: parser.defaultValues,
        descriptions: packageSettings.csvSettings.descriptionIndex != null
            ? parser.getColumn(packageSettings.csvSettings.descriptionIndex!)
            : null,
      );
      final prettyContent = encoder.convert(content.toJson());

      // write output file
      final path =
          '${packageSettings.outputDirectory}/${packageSettings.filenamePrepend}$supportedLanguage.arb';
      FileWriter().write(
        contents: prettyContent,
        path: path,
      );

      print('Generated $path');
    }

    print('All done!');
  }
}

ARBFile _generateARBFile({
  required String language,
  required List<String> keys,
  required List<String> values,
  required List<String> defaultValues,
  List<String>? descriptions,
}) {
  if (keys.length != values.length && keys.length != defaultValues.length) {
    print('Error! Mismatch number of keys and values');
    exit(0);
  }

  final messages = <Message>[];
  for (var i = 0; i < keys.length; i++) {
    final value = i < values.length && values[i].isNotEmpty
        ? values[i]
        : defaultValues[i];
    messages.add(Message(
      key: keys[i],
      value: value,
      description: descriptions?[i],
    ));
  }

  return ARBFile(locale: language, messages: messages);
}
