import 'dart:io';

import 'package:arb_generator/arb_generator.dart';

import 'utils/yaml_parser.dart';

void main() {
  final packageSettings = YamlParser.packageSettingsFromPubspec();
  if (packageSettings == null) {
    print('Error! Settings for arb_generator not found in pubspec.');
    exit(0);
  }

  ARBGenerator.generate(packageSettings);
}
