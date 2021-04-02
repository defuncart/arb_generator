import 'dart:io';

import 'package:flappy_translator/src/configs/constants.dart' as constants;
import 'package:flappy_translator/src/extensions/file_extensions.dart';
import 'package:flappy_translator/src/extensions/string_extensions.dart';
import 'package:flappy_translator/src/services/parsing/csv_parser.dart';

import '../models/package_settings.dart';

/// A service which generates arb files
abstract class ARBGenerator {
  /// Generates an output arb file
  static void generate(
    PackageSettings packageSettings,
  ) {
    // check that the file exists
    final file = File(packageSettings.inputFilepath);
    if (!file.existsSync()) {
      print('Error! File ${packageSettings.inputFilepath} does not exist!');
      exit(0);
    }

    // check that the file has an extension - this is needed to determine if the file is supported
    if (!file.path.contains('.')) {
      print('Error! No file extension specified!');
      exit(0);
    }

    // check that the file extension is correct
    if (!file.hasValidExtension) {
      print(
        'Error! File ${packageSettings.inputFilepath} has extension ${file.extensionType} which is not supported!',
      );
    }

    final parser = CSVParser(
      file: file,
      startIndex: packageSettings.csvSettings.columnIndex,
      fieldDelimiter: packageSettings.csvSettings.delimiter,
    );

    final supportedLanguages = parser.supportedLanguages;
    for (final supportedLanguage in supportedLanguages) {
      if (!supportedLanguage.isValidLocale) {
        print('Error! $supportedLanguage isn\'t a valid locale. Expected locale of the form "en" or "en_US".');
        exit(0);
      }
      final languageCode = supportedLanguage.split('_').first;
      if (!constants.flutterLocalizedLanguages.contains(languageCode)) {
        print('Warning! $languageCode isn\'t supported by default in Flutter.');
        print(
            'Please see https://flutter.dev/docs/development/accessibility-and-localization/internationalization#adding-support-for-a-new-language for info on how to add required classes.');
      }
    }
    // codeGenerator.setSupportedLanguages(supportedLanguages);
    // FlappyLogger.logProgress('Locales $supportedLanguages determined.');

    // final localizationsTable = parser.localizationsTable;
    // FlappyLogger.logProgress('Parsing ${localizationsTable.length} keys...');

    // for (final row in localizationsTable) {
    //   final key = row.first;

    //   if (constants.reservedWords.contains(key)) {
    //     FlappyLogger.logError('Key $key in row $row is a reserved keyword in Dart and is thus invalid.');
    //   }

    //   if (constants.types.contains(key)) {
    //     FlappyLogger.logError('Key $key in row $row is a type in Dart and is thus invalid.');
    //   }

    //   if (!key.isValidVariableName) {
    //     FlappyLogger.logError('Key $key in row $row is invalid. Expected key in the form lowerCamelCase.');
    //   }

    //   final words = row.sublist(startIndex);
    //   if (words.length > supportedLanguages.length) {
    //     FlappyLogger.logError(
    //         'The row $row does not seem to be well formatted. Found ${words.length} values for ${supportedLanguages.length} locales.');
    //   }

    //   final defaultWord = words[0];
    //   if (defaultWord.isEmpty) {
    //     FlappyLogger.logError('Key $key in row $row has no translation for default language.');
    //   }

    //   codeGenerator.addField(key, defaultWord, words);
    // }
  }
}
