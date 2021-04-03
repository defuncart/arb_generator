// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(count) => "${Intl.plural(count, zero: 'You have no new messages', one: 'You have 1 new message', other: 'You have ${count} new messages')}";

  static m1(howMany, userName) => "${Intl.plural(howMany, zero: 'There are no unread emails for ${userName}', one: 'There is 1 unread email for ${userName}', other: 'There are ${howMany} unread emails for ${userName}')}";

  static m2(firstName) => "Welcome ${firstName}!";

  static m3(sex) => "${Intl.gender(sex, female: 'Her book', male: 'His book', other: 'Their book')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "myKey" : MessageLookupByLibrary.simpleMessage("Hello world!"),
    "numberMessages" : m0,
    "unreadEmails" : m1,
    "welcome" : m2,
    "whoseBook" : m3
  };
}
