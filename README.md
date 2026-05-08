# arb_generator

A dart tool which generates ARB localization files from CSV files.

## Features

- CSV → ARB conversion
- Flutter intl compatible
- ICU placeholder, plural and select support
- Placeholder metadata support
- Multi-language generation

## Getting Started

### Add dependency

Add the package as a dev dependency:

```yaml   
dev_dependencies: 
  arb_generator:
```

### Define Settings

Next define arb_generator package settings in `pubspec.yaml`:

```yaml
arb_generator:
  input_filepath: "assets_dev/test.csv"
  output_directory: "lib/l10n"
  filename_prepend: "intl_"
  csv_settings:
    delimiter: ";"
    description_index: 1
    base_index: 2
```

| Setting                         | Description                                                                   |
| ------------------------------- | ------------------------------------------------------------------------------|
| input_filepath                  | Required. A path to the input CSV file.                                       |
| output_directory                | A directory to generate the output ARB file(s). Defaults to `lib/l10n`        |
| filename_prepend                | Text to prepend to filename of generated files. Defaults to empty string.     |
| csv_settings: delimiter         | A delimiter to separate columns in the input CSV file. Defaults to `,`.       |
| csv_settings: description_index | The description column index. Defaults to `null` (i.e. no description given)  |
| csv_settings: base_index        | The column index of the base language in the input CSV file. Defaults to `1`. |

### Run package

Run the following command from your project root:

```sh
dart run arb_generator
```

ARB files are then generated in `output_directory`.

## Generated Output

A CSV file of the form

|keys|description|en|de|
|-|-|-|-|
|myKey|The conventional newborn programmer greeting|Hello world!|Hallo Welt!|
|welcome|A welcome message|Welcome {firstName}!|Willkommen {firstName}!|
|numberMessages|An info message about new messages count|{count, plural, zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}}|{count, plural, zero{Du hast keine neue Nachrichten} one{Du hast eine neue Nachricht} other{Du hast {count} neue Nachrichten}}|
|whoseBook|A message determining whose book it is|{sex, select, male{His book} female{Her book} other{Their book}}|{sex, select, male{Sein Buch} female{Ihr Buch} other{Ihr Buch}}|

generates the following ARB files:

**en.arb**

```json
{
  "@@locale": "en",
  "myKey": "Hello world!",
  "@myKey": {
    "description": "The conventional newborn programmer greeting"
  },
  "welcome": "Welcome {firstName}!",
  "@welcome": {
    "description": "A welcome message"
  },
  "numberMessages": "{count, plural, zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}}",
  "@numberMessages": {
    "description": "An info message about new messages count"
  },
  "whoseBook": "{sex, select, male{His book} female{Her book} other{Their book}}",
  "@whoseBook": {
    "description": "A message determining whose book it is"
  }
}
```

**de.arb**

```json
{
  "@@locale": "de",
  "myKey": "Hallo Welt!",
  "@myKey": {
    "description": "The conventional newborn programmer greeting"
  },
  "welcome": "Willkommen {firstName}!",
  "@welcome": {
    "description": "A welcome message"
  },
  "numberMessages": "{count, plural, zero{Du hast keine neue Nachrichten} one{Du hast eine neue Nachricht} other{Du hast {count} neue Nachrichten}}",
  "@numberMessages": {
    "description": "An info message about new messages count"
  },
  "whoseBook": "{sex, select, male{Sein Buch} female{Ihr Buch} other{Ihr Buch}}",
  "@whoseBook": {
    "description": "A message determining whose book it is"
  }
}
```

## CSV Format

- The first column must contain translation keys
- Locale columns should use valid locale codes such as `en`, `de` or `en_US`
- The first row is treated as the header row
- ICU message syntax is supported in translation values

## Flutter Integration

See [example/l10n.yml](example/l10n.yml) and follow the [official documentation](https://docs.flutter.dev/ui/internationalization) to generate localization delegates from the ARB files.

## Optional Metadata

By default, if a description is given, it is added as metadata in the ARB file:

```json
"welcome": "Welcome {firstName}!",
"@welcome": {
  "description": "A welcome message",
}
```

Optional placeholder metadata can be supplied by adding a `json` file with the same filename as `input_filepath` input CSV file:

```json
{
  "@welcome": {
    "placeholders": {
      "firstName": {
        "type": "String",
        "example": "Dash"
      }
    }
  }
}
```

This metadata will then be copied into the generated file:

```json
"welcome": "Welcome {firstName}!",
"@welcome": {
  "description": "A welcome message",
  "placeholders": {
    "firstName": {
      "type": "String",
      "example": "Dash"
    }
  }
}
```

Now the generated delegates will expect `firstName` to be of type `String` not `Object`.

```dart
/// A welcome message
///
/// In en, this message translates to:
/// **'Welcome {firstName}!'**
String welcome(String firstName);
```

See [example/assets_dev/test.json](example/assets_dev/test.json) for more info.

## Collaboration

Spotted any issues? Please open [an issue on GitHub](https://github.com/defuncart/arb_generator/issues)! Would like to contribute a new feature? Fork the repo and submit a PR!
