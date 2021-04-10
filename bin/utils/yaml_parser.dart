import 'dart:io';

import 'package:arb_generator/arb_generator.dart'
    show CSVSettings, PackageSettings;
import 'package:yaml/yaml.dart';

/// A class of arguments which the user can specify in pubspec.yaml
class YamlArguments {
  static const inputFilepath = 'input_filepath';
  static const outputDirectory = 'output_directory';
  static const filenamePrepend = 'filename_prepend';
  static const csvSettings = 'csv_settings';
}

/// A class of arguments which the user can specify in pubspec.yaml for csv_settings object
class YamlCSVArguments {
  static const delimiter = 'delimiter';
  static const descriptionIndex = 'description_index';
  static const baseIndex = 'base_index';
}

/// A class which parses yaml
class YamlParser {
  /// The path to the pubspec file path
  static const pubspecFilePath = 'pubspec.yaml';

  /// The section id for package settings in the yaml file
  static const yamlPackageSectionId = 'arb_generator';

  /// Returns the package settings from pubspec
  static PackageSettings? packageSettingsFromPubspec() {
    final yamlMap = _packageSettingsAsYamlMap();
    if (yamlMap != null) {
      final inputFilepath = yamlMap[YamlArguments.inputFilepath];
      if (inputFilepath == null) {
        print('Error! Input filepath not defined!');
        exit(0);
      }

      final csvSettings = _csvSettingsFromPubspec(yamlMap);
      if (csvSettings == null) {
        print('Warning! No CSV settings supplied, using defaults.');
      }

      return PackageSettings(
        inputFilepath: inputFilepath,
        outputDirectory: yamlMap[YamlArguments.outputDirectory],
        filenamePrepend: yamlMap[YamlArguments.filenamePrepend],
        csvSettings: csvSettings,
      );
    }

    return null;
  }

  /// Returns the csv settings from pubspec
  static CSVSettings? _csvSettingsFromPubspec(Map<dynamic, dynamic> yamlMap) {
    if (yamlMap.containsKey(YamlArguments.csvSettings)) {
      final csvSettingsAsYamlMap = yamlMap[YamlArguments.csvSettings];
      return CSVSettings(
        delimiter: csvSettingsAsYamlMap[YamlCSVArguments.delimiter],
        descriptionIndex:
            csvSettingsAsYamlMap[YamlCSVArguments.descriptionIndex],
        baseIndex: csvSettingsAsYamlMap[YamlCSVArguments.baseIndex],
      );
    }

    return null;
  }

  /// Returns the package settings from pubspec as a yaml map
  static Map<dynamic, dynamic>? _packageSettingsAsYamlMap() {
    final file = File(pubspecFilePath);
    final yamlString = file.readAsStringSync();
    final Map<dynamic, dynamic> yamlMap = loadYaml(yamlString);
    return yamlMap[yamlPackageSectionId];
  }
}
