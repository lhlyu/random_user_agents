import 'package:flutter_test/flutter_test.dart';
import 'package:random_user_agents/random_user_agents.dart';

void main() {
  test('random a user agent', () {
    expect(RandomUserAgents.random().isNotEmpty, true);
  });
}
