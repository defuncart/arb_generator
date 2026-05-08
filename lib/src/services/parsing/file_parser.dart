import 'dart:io';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import '../validation/validator.dart';

/// A base file parser which should be extended by supported file types
abstract class FileParser {
  /// The number of header lines (ie rows) before localizations start
  static const int _numberHeaderLines = 1;

  /// The file to parse
  final File file;

  /// The (column) index where localizations start
  final int startIndex;

  FileParser({
    required this.file,
    required this.startIndex,
  }) : assert(startIndex > 0);

  /// Internal method to parse [file] as a 2D array
  @protected
  List<List<String>> parseFile();

  /// Parses [file] and returns [LocalizationTable]
  LocalizationTable parse({int? descriptionIndex}) {
    final parsedContents = parseFile();

    final supportedLanguages = parsedContents.first.sublist(startIndex);
    if (supportedLanguages.isEmpty) {
      print('No locales determined.');
      exit(0);
    }
    Validator.validateSupportedLanguages(supportedLanguages);

    List<String> getColumn(int index) => parsedContents
        .sublist(_numberHeaderLines)
        .map((row) => row[index])
        .toList(growable: false);

    final keys = getColumn(0);
    if (keys.isEmpty) {
      print('No keys found.');
      exit(0);
    }

    final descriptions = descriptionIndex != null
        ? getColumn(descriptionIndex)
        : null;

    // validate descriptions length is same as keys

    // create a mxn table (keys x languages) where each localization defaults to key
    final locaColumns = {
      for (final supportedLanguage in supportedLanguages)
        supportedLanguage: List<String>.from(keys),
    };
    // loop through parsed contents and update
    for (final (rowIndex, row)
        in parsedContents.sublist(_numberHeaderLines).indexed) {
      final rawCols = row.sublist(startIndex);
      for (final (colIndex, element) in rawCols.indexed) {
        final supportedLanguage = supportedLanguages[colIndex];
        final effectiveValue = element.isNotEmpty ? element : rawCols.first;

        // validate effective value

        if (effectiveValue.isNotEmpty) {
          locaColumns[supportedLanguage]![rowIndex] = effectiveValue;
        }
      }
    }

    final rows = <LocalizationTableRow>[];
    for (final (index, key) in keys.indexed) {
      rows.add(
        LocalizationTableRow(
          key: key,
          description: descriptions?[index],
          values: {
            for (final supportedLanguage in supportedLanguages)
              supportedLanguage: locaColumns[supportedLanguage]![index],
          },
        ),
      );
    }

    return LocalizationTable(
      supportedLanguages: supportedLanguages,
      rows: rows,
    );
  }
}

/// A model representing a localization table
class LocalizationTable {
  const LocalizationTable({
    required this.supportedLanguages,
    required this.rows,
  });

  final List<String> supportedLanguages;
  final List<LocalizationTableRow> rows;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    final listEquals = const DeepCollectionEquality().equals;

    return other is LocalizationTable &&
        listEquals(other.supportedLanguages, supportedLanguages) &&
        listEquals(other.rows, rows);
  }

  @override
  int get hashCode => supportedLanguages.hashCode ^ rows.hashCode;

  @override
  String toString() =>
      'LocalizationTable(supportedLanguages: $supportedLanguages, rows: $rows)';
}

/// A model representing a row in a [LocalizationTable]
class LocalizationTableRow {
  const LocalizationTableRow({
    required this.key,
    required this.description,
    required this.values,
  });

  final String key;
  final String? description;
  final Map<String, String> values;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    final mapEquals = const DeepCollectionEquality().equals;
    return other is LocalizationTableRow &&
        other.key == key &&
        other.description == description &&
        mapEquals(other.values, values);
  }

  @override
  int get hashCode => key.hashCode ^ description.hashCode ^ values.hashCode;

  @override
  String toString() =>
      'LocalizationTableRow(key: $key, description: $description, values: $values)';
}
