library random_user_agents;

import 'dart:math';

part 'user_agents.dart';

/// Random UserAgents
class RandomUserAgents {
  /// a filter function
  final bool Function(String value) filter;

  /// a filtered list of user agents
  final List<String> _list;

  /// Return an instance of RandomUserAgents using a private named constructor.
  /// The instance is created with a filter function and a filtered list of user agents.
  factory RandomUserAgents(bool Function(String value) filter) {
    return RandomUserAgents._internal(
      filter,
      _userAgents.where(filter).toList(),
    );
  }

  /// a private named constructor
  RandomUserAgents._internal(this.filter, this._list);

  /// Return a random user agent string
  static String random({String pattern = ""}) {
    Random random = Random();
    return _userAgents[random.nextInt(_userAgents.length)];
  }

  /// Return a random user agent string
  String getUserAgent() {
    Random random = Random();
    return _list[random.nextInt(_list.length)];
  }
}
