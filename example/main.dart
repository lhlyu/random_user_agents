import 'package:random_user_agents/random_user_agents.dart';

void main() {
  /// direct use
  /// 直接使用
  final ua = RandomUserAgents.random();
  print(ua);
  // output: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36

  /// with filter function
  /// 使用自定义过滤函数
  final u = RandomUserAgents((value) {
    return value.contains("Android");
  });
  print(u.getUserAgent());
  // output: Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Mobile Safari/537.36

  /// without filter function
  /// 无过滤函数
  final r = RandomUserAgents();
  print(r.getUserAgent());
  // output: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Safari/605.1.15
}
