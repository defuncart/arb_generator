import 'dart:io';

import 'package:arb_generator/src/services/parsing/csv_parser.dart';

import '../extensions/file_extensions.dart';
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
  }
}
