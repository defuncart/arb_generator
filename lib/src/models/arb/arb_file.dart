class ARBFile {
  const ARBFile({
    required this.locale,
    required this.messages,
  });

  final String locale;
  final List<StandardMessage> messages;

  Map<String, dynamic> toJson() => {
        '@@locale': locale,
        for (final message in messages) message.key: message.value,
      };
}

class StandardMessage {
  const StandardMessage({
    required this.key,
    required this.value,
  });

  final String key;
  final String value;
}
