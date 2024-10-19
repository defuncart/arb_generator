import 'dart:io';

import '../enums/supported_input_file_type.dart';

extension FileExtensions on File {
  String get extensionType => path.split('.').last.toLowerCase();

  bool get hasValidExtension => SupportedInputFileType.values
      .map((value) => value.name)
      .contains(extensionType);
}
