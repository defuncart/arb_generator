class ARBFile {
  const ARBFile({
    required this.locale,
    required this.messages,
  });

  final String locale;
  final List<Message> messages;

  Map<String, dynamic> toJson() => {
    '@@locale': locale,
    for (final message in messages) ...message.toJson(),
  };
}

class Message {
  const Message({
    required this.key,
    required this.value,
    this.description,
    this.metadata,
  });

  final String key;
  final String value;
  final String? description;
  final Map<String, dynamic>? metadata;

  Map<String, dynamic> toJson() => {
    key: value,
    '@$key': {
      'description': ?description,
      ...?metadata,
    },
  };
}
