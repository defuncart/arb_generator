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
  });

  final String key;
  final String value;
  final String? description;

  Map<String, dynamic> toJson() => {
        key: value,
        '@$key': {
          if (description != null) 'description': description,
        }
      };
}
