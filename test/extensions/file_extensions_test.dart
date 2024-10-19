import 'package:arb_generator/src/extensions/file_extensions.dart';
import 'package:test/test.dart';

import 'temp_file_handler.dart';

void main() {
  test('CSV file with valid extension', () {
    tempFileHandler('test.csv', (file) {
      expect(file.extensionType, 'csv');
      expect(file.hasValidExtension, true);
    });
  });

  test('CSV filepath in capitals', () {
    tempFileHandler('TEST.CSV', (file) {
      expect(file.extensionType, 'csv');
      expect(file.hasValidExtension, true);
    });
  });
}
