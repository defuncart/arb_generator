import 'package:arb_generator/arb_generator.dart';
import 'package:arb_generator/src/services/validation/validator.dart';
import 'package:test/test.dart';

void main() {
  group('validateCSVSettings', () {
    test('Valid settings delimiter, baseIndex expect true', () {
      const csvSettings = CSVSettings(
        delimiter: ',',
        baseIndex: 1,
      );
      expect(Validator.validateCSVSettings(csvSettings), isTrue);
    });

    test('Valid settings all expect true', () {
      const csvSettings = CSVSettings(
        delimiter: ',',
        baseIndex: 2,
        descriptionIndex: 1,
      );
      expect(Validator.validateCSVSettings(csvSettings), isTrue);
    });

    test('baseIndex < 1 expect false', () {
      const csvSettings = CSVSettings(
        delimiter: ',',
        baseIndex: 0,
      );
      expect(Validator.validateCSVSettings(csvSettings), isFalse);
    });

    test('descriptionIndex < 1 expect false', () {
      const csvSettings = CSVSettings(
        delimiter: ',',
        baseIndex: 1,
        descriptionIndex: 0,
      );
      expect(Validator.validateCSVSettings(csvSettings), isFalse);
    });

    test('descriptionIndex >= baseIndex expect false', () {
      const csvSettings = CSVSettings(
        delimiter: ',',
        baseIndex: 0,
        descriptionIndex: 1,
      );
      expect(Validator.validateCSVSettings(csvSettings), isFalse);
    });
  });
}
