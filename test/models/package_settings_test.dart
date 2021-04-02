import 'package:arb_generator/src/configs/default_settings.dart';
import 'package:arb_generator/src/models/package_settings.dart';
import 'package:test/test.dart';

void main() {
  test('When nullable constructor params are null, expect defaults', () {
    final packageSettings = PackageSettings(
      inputFilepath: 'loca.csv',
      outputDir: null,
      filenamePrepend: null,
      csvSettings: null,
    );

    expect(packageSettings.inputFilepath, 'loca.csv');
    expect(packageSettings.outputDirectory, DefaultSettings.outputDirectory);
    expect(packageSettings.filenamePrepend, DefaultSettings.filenamePrepend);
    expect(packageSettings.csvSettings, isNotNull);
  });

  test('Expect toString is overridden', () {
    final packageSettings = PackageSettings(
      inputFilepath: 'loca.csv',
      outputDir: null,
      filenamePrepend: null,
      csvSettings: null,
    );

    expect(packageSettings.toString(), isNot("Instance of 'PackageSettings'"));
  });
}
