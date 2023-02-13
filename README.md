# arb_generator

A dart tool which generates ARB files from CSV files.

## Getting Started

A CSV file of the form

|keys|description|en|de|
|-|-|-|-|
|myKey|The conventional newborn programmer greeting|Hello world!|Hallo Welt!|
|welcome|A welcome message|Welcome {firstName}!|Willkommen {firstName}!|
|numberMessages|An info message about new messages count|{count, plural, zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}}|{count, plural, zero{Du hast keine neue Nachrichten} one{Du hast eine neue Nachricht} other{Du hast {count} neue Nachrichten}}|
|whoseBook|A message determine whose book it is|{sex, select, male{His book} female{Her book} other{Their book}}|{sex, select, male{Sein Buch} female{Ihr Buch} other{Ihr Buch}}|

is generated into the following ARB file

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
    "description": "A message determine whose book it is"
  }
}
```

This ARB file can then be converted into localization delegates using [intl](https://docs.flutter.dev/development/accessibility-and-localization/internationalization#adding-your-own-localized-messages) or [intl_utils](https://pub.dev/packages/intl_utils).

### Add dependency

Firstly, add the package as a dev dependency:

```yaml   
dev_dependencies: 
  arb_generator:
```

Note that arb_generator requires dart sdk >= 2.12.

### Define Settings

Next define arb_generator package settings in `pubspec.yaml`. Note that `input_filepath` is the only required parameter.

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
| output_directory                | A directory to generate the output ARB file(s). Defaults to `lib/l10`         |
| filename_prepend                | Text to prepend to filename of generated files. Fefaults to empty string.     |
| csv_settings: delimiter         | A delimiter to separate columns in the input CSV file. Defaults to `,`.       |
| csv_settings: description_index | The description column index. Defaults to `null`.                             |
| csv_settings: base_index        | The column index of the base language in the input CSV file. Defaults to `1`. |

### Run package

Ensure that your current working directory is the project root. Depending on your project, run one of the following commands:

```sh
dart run arb_generator
```

or

```sh
flutter pub run arb_generator
```

ARB files are then generated in `output_dir`.

## Collaboration

Spotted any issues? Please open [an issue on GitHub](https://github.com/defuncart/arb_generator/issues)! Would like to contribute a new language or feature? Fork the repo and submit a PR!
