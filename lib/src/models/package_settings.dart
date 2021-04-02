import '../configs/default_settings.dart';
import 'csv_settings.dart';

/// A model representing package settings
class PackageSettings {
  /// The filepath for the input localization file. This must be supplied.
  final String inputFilepath;

  /// A directory for the generated files Defaults to `lib/l10n`.
  final String outputDir;

  /// A directory for the generated files Defaults to `lib/l10n`.
  final String filenamePrepend;

  /// Text to prepend to filename of generated files. Defaults to empty string.
  final CSVSettings csvSettings;

  /// Constructs a new instance of [PackageSettings]
  PackageSettings({
    required this.inputFilepath,
    required String? outputDir,
    required String? filenamePrepend,
    CSVSettings? csvSettings,
  })  : outputDir = outputDir ?? DefaultSettings.outputDir,
        filenamePrepend = outputDir ?? DefaultSettings.filenamePrepend,
        csvSettings = csvSettings ?? CSVSettings.withDefaultSettings();

  /// Returns a String representation of the model.
  @override
  String toString() => '{inputFilepath: $inputFilepath, outputDir: $outputDir, csvSettings: $csvSettings';
}
