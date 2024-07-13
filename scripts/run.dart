import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;

void main() async {
  const gz = "https://github.com/intoli/user-agents/raw/main/src/user-agents.json.gz";
  await downloadAndExtractGzip(gz);
}

Future<void> downloadAndExtractGzip(String url) async {
  // 下载文件
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // 创建gzip解码器
    final gzipDecoder = GZipDecoder();

    // 将下载的内容转换为字节
    List<int> gzipBytes = response.bodyBytes;

    // 解压gzip文件
    List<int> decodedBytes = gzipDecoder.decodeBytes(gzipBytes);

    String decodedString = utf8.decode(decodedBytes);

    final List<dynamic> decodedJson = json.decode(decodedString);

    StringBuffer buffer = StringBuffer();

    buffer.write("part of 'random_user_agents.dart';\n\n");
    buffer.write("const mockUserAgents = [\n");

    Set<String> set = {};

    for (var val in decodedJson) {
      final userAgent = val['userAgent'];
      if (set.contains(userAgent)) {
        continue;
      }
      set.add(userAgent);
      buffer.write("  '$userAgent',\n");
    }
    buffer.write("];\n");

    const filename = './lib/mock.dart';

    await File(filename).writeAsString(buffer.toString());

    log("文件生成成功");
  } else {
    throw Exception('无法下载文件: ${response.statusCode}');
  }
}
