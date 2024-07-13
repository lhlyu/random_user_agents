# Random_User_Agents

[![pub package](https://img.shields.io/pub/v/random_user_agents.svg)](https://pub.dev/packages/random_user_agents)

A flutter package for generating random user agents.
随机生成User-Agent.


## Getting started

```shell 
flutter pub add random_user_agents
```

## Usage


```dart
import 'package:random_user_agents/random_user_agents.dart';

void main() {
  final ua = RandomUserAgents.random();
  print(ua);
  // output: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36
}
```
