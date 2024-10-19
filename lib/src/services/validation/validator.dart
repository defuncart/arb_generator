import 'dart:io';

import '../../configs/constants.dart' as constants;
import '../../extensions/file_extensions.dart';
import '../../extensions/string_extensions.dart';
import '../../models/settings/csv_settings.dart';
import '../parsing/file_parser.dart';

abstract class Validator {
  /// Validates whether [file] is valid
  ///
  /// If any error occurs, process is terminated
  static void validateFile(File file) {
    // check that the file exists
    if (!file.existsSync()) {
      print('File ${file.path} does not exist!');
    }

    // check that the file extension is correct
    if (!file.hasValidExtension) {
      print(
        'File ${file.path} has extension ${file.extensionType} which is not supported!',
      );
    }
  }

  /// Validates whether [supportedLanguages] are valid
  ///
  /// If any error occurs, process is terminated
  static void validateSupportedLanguages(List<String> supportedLanguages) {
    for (final supportedLanguage in supportedLanguages) {
      if (!supportedLanguage.isValidLocale) {
        print(
            '$supportedLanguage isn\'t a valid locale. Expected locale of the form "en" or "en_US".');
      }

      final languageCode = supportedLanguage.split('_').first;
      if (!constants.flutterLocalizedLanguages.contains(languageCode)) {
        print('$languageCode isn\'t supported by default in Flutter.');
        print(
            'Please see https://flutter.dev/docs/development/accessibility-and-localization/internationalization#adding-support-for-a-new-language for info on how to add required classes.');
      }
    }
  }

  /// Validates whether [localizationsTable] is valid
  ///
  /// If any error occurs, process is terminated
  static void validateLocalizationsTable(
      List<LocalizationTableRow> localizationsTable) {
    if (localizationsTable.isEmpty) {
      print('No keys found.');
    }
  }

  /// Validates whether [row] is valid
  ///
  /// If any error occurs, process is terminated
  static void validateLocalizationTableRow(
    LocalizationTableRow row, {
    required int numberSupportedLanguages,
  }) {
    final key = row.key;
    if (constants.reservedWords.contains(key)) {
      print(
          'Key $key in row ${row.raw} is a reserved keyword in Dart and is thus invalid.');
    }

    if (constants.types.contains(key)) {
      print(
          'Key $key in row ${row.raw} is a type in Dart and is thus invalid.');
    }

    if (!key.isValidVariableName) {
      print(
          'Key $key in row ${row.raw} is invalid. Expected key in the form lowerCamelCase.');
    }

    final words = row.words;
    if (words.length > numberSupportedLanguages) {
      print(
          'The row ${row.raw} does not seem to be well formatted. Found ${words.length} values for numberSupportedLanguages locales.');
    }

    final defaultWord = row.defaultWord;
    if (defaultWord.isEmpty) {
      print(
          'Key $key in row ${row.raw} has no translation for default language.');
    }
  }

  /// Validates whether a [csvSettings] instance has valid parameters
  ///
  /// All errors are logged to console
  static bool validateCSVSettings(CSVSettings csvSettings) {
    if (csvSettings.baseIndex < 1) {
      print(
          'Error! baseIndex = ${csvSettings.baseIndex} is not valid. Expected > 0');
      return false;
    }

    if (csvSettings.descriptionIndex != null &&
        csvSettings.descriptionIndex! < 1) {
      print(
          'Error! descriptionIndex = ${csvSettings.descriptionIndex} is not valid. Expected > 0');
      return false;
    }

    if (csvSettings.descriptionIndex != null &&
        csvSettings.descriptionIndex! >= csvSettings.baseIndex) {
      print(
          'Error! baseIndex = ${csvSettings.baseIndex} and descriptionIndex = ${csvSettings.descriptionIndex} are not valid. Expected descriptionIndex < baseIndex');
      return false;
    }

    return true;
  }
}
