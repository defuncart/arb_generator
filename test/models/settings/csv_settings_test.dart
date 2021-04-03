import 'package:arb_generator/src/configs/csv_default_settings.dart';
import 'package:arb_generator/src/models/settings/csv_settings.dart';
import 'package:test/test.dart';

void main() {
  test('When constructor params are null, expect defaults', () {
    final csvSettings = CSVSettings(
      delimiter: null,
      columnIndex: null,
    );

    expect(csvSettings.delimiter, CSVDefaultSettings.delimiter);
    expect(csvSettings.columnIndex, CSVDefaultSettings.columnIndex);
  });

  test('When constructor params are non-null, expect given', () {
    final csvSettings = CSVSettings(
      delimiter: ',',
      columnIndex: 1,
    );

    expect(csvSettings.delimiter, ',');
    expect(csvSettings.columnIndex, 1);
  });

  test('Expect toString is overridden', () {
    final csvSettings = CSVSettings(
      delimiter: null,
      columnIndex: null,
    );

    expect(csvSettings.toString(), isNot("Instance of 'CSVSettings'"));
  });
}
