import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../models/arb/arb_file.dart';
import '../models/settings/package_settings.dart';
import 'file_writer/file_writer.dart';
import 'parsing/csv_parser.dart';
import 'parsing/file_parser.dart';
import 'validation/validator.dart';

/// A service which generates arb files
abstract class ARBGenerator {
  /// Generates an output arb file
  static void generate(
    PackageSettings packageSettings,
  ) {
    // check that the file exists
    final file = File(packageSettings.inputFilepath);
    Validator.validateFile(file);

    if (!Validator.validateCSVSettings(packageSettings.csvSettings)) {
      exit(0);
    }

    // File is valid, state progress
    print('Loading file ${packageSettings.inputFilepath}...');

    // Try to load optional metadata
    final optionalMetadata = _loadOptionalMetadata(
      packageSettings.inputFilepath,
    );

    final parser = CSVParser(
      file: file,
      startIndex: packageSettings.csvSettings.baseIndex,
      fieldDelimiter: packageSettings.csvSettings.delimiter,
    );
    final table = parser.parse(
      descriptionIndex: packageSettings.csvSettings.descriptionIndex,
    );

    print('Locales ${table.supportedLanguages} determined.');
    print('Parsing ${table.rows.length} key(s)...');

    final encoder = JsonEncoder.withIndent('  ');

    // for (final row in localizationsTable) {
    //   Validator.validateLocalizationTableRow(
    //     row,
    //     numberSupportedLanguages: supportedLanguages.length,
    //   );
    // }

    for (final supportedLanguage in table.supportedLanguages) {
      final content = _generateARBFile(
        language: supportedLanguage,
        rows: table.rows,
        optionalMetadata: optionalMetadata,
      );
      var prettyContent = encoder.convert(content.toJson());
      // convert turns \n into \\n
      prettyContent = prettyContent.replaceAll('\\\\', '\\');

      // write output file
      final path = p.join(
        packageSettings.outputDirectory,
        '${packageSettings.filenamePrepend}$supportedLanguage.arb',
      );
      FileWriter().write(
        contents: prettyContent,
        path: path,
      );

      print('Generated $path');
    }

    print('All done!');
  }
}

Map<String, dynamic>? _loadOptionalMetadata(
  String inputFilepath,
) {
  final optionalMetadataPath = p.setExtension(
    inputFilepath,
    '.json',
  );
  final optionalMetadataFile = File(optionalMetadataPath);
  final contents = optionalMetadataFile.existsSync()
      ? json.decode(optionalMetadataFile.readAsStringSync())
      : null;
  if (contents != null) {
    print('Loading optional metadata $optionalMetadataPath...');
  }

  return contents;
}

ARBFile _generateARBFile({
  required String language,
  required List<LocalizationTableRow> rows,
  Map<String, dynamic>? optionalMetadata,
}) {
  final messages = rows
      .map(
        (row) => Message(
          key: row.key,
          description: row.description,
          value: row.values[language]!,
          // safety check in case user forgot @
          metadata:
              optionalMetadata?['@${row.key}'] ?? optionalMetadata?[row.key],
        ),
      )
      .toList();

  return ARBFile(locale: language, messages: messages);
}
