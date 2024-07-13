library random_user_agents;

import 'dart:math';

part 'mock.dart';

/// Define a type for a function that takes a string parameter and returns a bool.
typedef BoolFunctionType = bool Function(String value);

/// Random UserAgents
class RandomUserAgents {
  /// a filter function
  final BoolFunctionType filter;

  /// a filtered list of mock user agents
  final List<String> _mocks;

  /// Return an instance of RandomUserAgents using a private named constructor.
  /// The instance is created with a filter function and a filtered list of mock user agents.
  factory RandomUserAgents(BoolFunctionType filter) {
    return RandomUserAgents._internal(
      filter,
      mockUserAgents.where(filter).toList(),
    );
  }

  RandomUserAgents._internal(this.filter, this._mocks);

  /// Return a random user agent string
  static String random({String pattern = ""}) {
    Random random = Random();
    return mockUserAgents[random.nextInt(mockUserAgents.length)];
  }

  /// Return a random user agent string
  String getUserAgent() {
    Random random = Random();
    return _mocks[random.nextInt(_mocks.length)];
  }
}
