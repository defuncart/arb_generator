import 'package:arb_generator/src/configs/csv_default_settings.dart';
import 'package:arb_generator/src/models/settings/csv_settings.dart';
import 'package:test/test.dart';

void main() {
  test('When constructor params are null, expect defaults', () {
    final csvSettings = CSVSettings(
      delimiter: null,
      baseIndex: null,
    );

    expect(csvSettings.delimiter, CSVDefaultSettings.delimiter);
    expect(csvSettings.descriptionIndex, isNull);
    expect(csvSettings.baseIndex, CSVDefaultSettings.columnIndex);
  });

  test('withDefaultSettings, expect defaults', () {
    final csvSettings = CSVSettings.withDefaultSettings();

    expect(csvSettings.delimiter, CSVDefaultSettings.delimiter);
    expect(csvSettings.descriptionIndex, isNull);
    expect(csvSettings.baseIndex, CSVDefaultSettings.columnIndex);
  });

  test('When constructor params are non-null, expect given', () {
    final csvSettings = CSVSettings(
      delimiter: ',',
      descriptionIndex: 1,
      baseIndex: 2,
    );

    expect(csvSettings.delimiter, ',');
    expect(csvSettings.descriptionIndex, 1);
    expect(csvSettings.baseIndex, 2);
  });

  test('Expect toString is overridden', () {
    final csvSettings = CSVSettings.withDefaultSettings();

    expect(csvSettings.toString(), isNot("Instance of 'CSVSettings'"));
  });
}
