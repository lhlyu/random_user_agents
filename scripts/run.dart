import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;

/// 更新数据，格式化代码，更新版本号
/// 执行后，发布包
/// 检查是否有任何发布前的问题：dart pub publish.yaml --dry-run
/// dart pub publish.yaml
void main() async {
  await downloadAndExtractGzip();
  await formatCode();
  await updateVersion();
}

/// 更新数据
Future<void> downloadAndExtractGzip() async {
  const url =
      "https://github.com/intoli/user-agents/raw/main/src/user-agents.json.gz";
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
    buffer.write("/// user agents data\n");
    buffer.write("const _userAgents = [\n");

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

    const filename = './lib/user_agents.dart';

    await File(filename).writeAsString(buffer.toString());

    print("数据更新成功");
  } else {
    throw Exception('无法下载文件: ${response.statusCode}');
  }
}

/// 代码格式化
Future<void> formatCode() async {
  var result = await Process.run('dart', ['format', '.']);
  // 如果有错误，打印错误信息
  if (result.stderr.isNotEmpty) {
    throw Exception(result.stderr);
  }
  print('代码格式化完成');
}

// 修改CHANGELOG.md
Future<void> updateChangelog(String version) async {
  const filePath = './CHANGELOG.md';
  final file = File(filePath);
  var content = await file.readAsString();
  content = '## $version\n\n- user agent data update\n\n$content';
  await file.writeAsString(content);
  print('修改CHANGELOG完成');
}

// 修改版本号
Future<void> updateVersion() async {
  const filePath = './pubspec.yaml';
  final file = File(filePath);
  var content = await file.readAsString();

  RegExp regExp = RegExp(r'version:\s*.+');

  var nVersion = '';

  content = content.replaceFirstMapped(regExp, (match) {
    final version = match.group(0)?.toString() ?? '0.0.1';
    final versions = version.split('.');
    final lastVersionNumber = int.parse(versions.last) + 1;
    versions[versions.length - 1] = '$lastVersionNumber';
    final newVersion = versions.join('.');
    nVersion = newVersion.replaceFirst('version: ', '');
    print(
      '${version.replaceFirst('version: ', '')} -> $nVersion',
    );
    return newVersion;
  });

  await file.writeAsString(content);
  print('版本修改完成: $nVersion');

  await updateChangelog(nVersion);
}
