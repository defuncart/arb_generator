import '../../models/settings/csv_settings.dart';

abstract class Validator {
  /// Validates whether a [csvSettings] instance has valid parameters
  ///
  /// All errors are logged to console
  static bool validateCSVSettings(CSVSettings csvSettings) {
    if (csvSettings.baseIndex < 1) {
      print('Error! baseIndex value ${csvSettings.baseIndex} is not valid. Expected > 0');
      return false;
    }

    if (csvSettings.descriptionIndex != null && csvSettings.descriptionIndex! < 1) {
      print('Error! descriptionIndex value ${csvSettings.descriptionIndex} is not valid. Expected > 0');
      return false;
    }

    if (csvSettings.descriptionIndex != null && csvSettings.descriptionIndex! >= csvSettings.baseIndex) {
      print(
          'Error! baseIndex value ${csvSettings.baseIndex} and descriptionIndex value ${csvSettings.descriptionIndex} are not valid. Expected descriptionIndex < baseIndex');
      return false;
    }

    return true;
  }
}
