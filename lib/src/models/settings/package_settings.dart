import '../../configs/package_default_settings.dart';
import 'csv_settings.dart';

/// A model representing package settings
class PackageSettings {
  /// The filepath for the input localization file. This must be supplied.
  final String inputFilepath;

  /// A directory for the generated files. Defaults to `lib/l10n`.
  final String outputDirectory;

  /// Text to prepend to filename of generated files. Defaults to empty string.
  final String filenamePrepend;

  /// A model of csv settings.
  final CSVSettings csvSettings;

  /// Constructs a new instance of [PackageSettings]
  PackageSettings({
    required this.inputFilepath,
    required String? outputDirectory,
    required String? filenamePrepend,
    CSVSettings? csvSettings,
  })  : outputDirectory = outputDirectory ?? PackageDefaultSettings.outputDirectory,
        filenamePrepend = filenamePrepend ?? PackageDefaultSettings.filenamePrepend,
        csvSettings = csvSettings ?? CSVSettings.withDefaultSettings();

  /// Returns a String representation of the model.
  @override
  String toString() =>
      '{inputFilepath: $inputFilepath, outputDirectory: $outputDirectory, filenamePrepend: $filenamePrepend, csvSettings: $csvSettings';
}
