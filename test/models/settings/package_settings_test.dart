import 'package:arb_generator/src/configs/package_default_settings.dart';
import 'package:arb_generator/src/models/settings/package_settings.dart';
import 'package:test/test.dart';

void main() {
  test('When nullable constructor params are null, expect defaults', () {
    final packageSettings = PackageSettings(
      inputFilepath: 'loca.csv',
      outputDirectory: null,
      filenamePrepend: null,
      csvSettings: null,
    );

    expect(packageSettings.inputFilepath, 'loca.csv');
    expect(
      packageSettings.outputDirectory,
      PackageDefaultSettings.outputDirectory,
    );
    expect(
      packageSettings.filenamePrepend,
      PackageDefaultSettings.filenamePrepend,
    );
    expect(packageSettings.csvSettings, isNotNull);
  });

  test('Expect toString is overridden', () {
    final packageSettings = PackageSettings(
      inputFilepath: 'loca.csv',
      outputDirectory: null,
      filenamePrepend: null,
      csvSettings: null,
    );

    expect(packageSettings.toString(), isNot("Instance of 'PackageSettings'"));
  });
}
