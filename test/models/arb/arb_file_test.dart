import 'package:arb_generator/src/models/arb/arb_file.dart';
import 'package:test/test.dart';

void main() {
  group('Message', () {
    test('When description is null, expect empty @key', () {
      final message = Message(key: 'myKey', value: 'myValue');
      expect(
        message.toJson(),
        {
          'myKey': 'myValue',
          '@myKey': {},
        },
      );
    });

    test('When description is not null, expect non-empty @key', () {
      final message = Message(
        key: 'myKey',
        value: 'myValue',
        description: 'myDescription',
      );
      expect(
        message.toJson(),
        {
          'myKey': 'myValue',
          '@myKey': {
            'description': 'myDescription',
          },
        },
      );
    });
  });

  group('ARBFile', () {
    test('When messages is empty, expect only locale', () {
      final arbFile = ARBFile(locale: 'en', messages: []);
      expect(
        arbFile.toJson(),
        {
          '@@locale': 'en',
        },
      );
    });

    test('When messages is not empty, expect correct json', () {
      final arbFile = ARBFile(
        locale: 'en',
        messages: [
          Message(key: 'myKey', value: 'myValue'),
        ],
      );
      expect(
        arbFile.toJson(),
        {
          '@@locale': 'en',
          'myKey': 'myValue',
          '@myKey': {},
        },
      );
    });
  });
}
