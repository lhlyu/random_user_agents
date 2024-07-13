library random_user_agents;

import 'dart:math';

part 'mock.dart';

class RandomUserAgents {
  static String random() {
    Random random = Random();
    return mockUserAgents[random.nextInt(mockUserAgents.length)];
  }
}
