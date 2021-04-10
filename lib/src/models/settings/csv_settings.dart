import '../../configs/csv_default_settings.dart';

/// A model representing CSV File parsing settings
class CSVSettings {
  /// The delimiter to use. Defaults to `,`.
  final String delimiter;

  /// The description column index.
  final int? descriptionIndex;

  /// The base language's column index. Defaults to `1`.
  final int baseIndex;

  /// Constructs a new instance of [CSVSettings]
  ///
  /// The parameter [delimiter] is required. If null, defaults to `,`.
  /// The parameter [baseIndex] is required. If null, defaults to `1`.
  /// The parameter [descriptionIndex] is optional.
  const CSVSettings({
    required String? delimiter,
    required int? baseIndex,
    this.descriptionIndex,
  })  : delimiter = delimiter ?? CSVDefaultSettings.delimiter,
        baseIndex = baseIndex ?? CSVDefaultSettings.columnIndex;

  /// Consts a new instance of `CSVSettings` whose parameters are given default values.
  CSVSettings.withDefaultSettings() : this(delimiter: null, baseIndex: null);

  /// Returns a String representation of the model.
  @override
  String toString() =>
      '{delimiter: $delimiter, descriptionIndex: $descriptionIndex, baseIndex: $baseIndex}';
}
