import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vaani/features/logging/core/logger.dart';

part 'logs_provider.g.dart';

@riverpod
class Logs extends _$Logs {
  @override
  Future<List<LogRecord>> build() async {
    final path = await getLoggingFilePath();
    final file = File(path);
    if (!file.existsSync()) {
      return [];
    }
    final lines = await file.readAsLines();
    return lines.map(parseLogLine).toList();
  }

  Future<void> clear() async {
    final path = await getLoggingFilePath();
    final file = File(path);
    await file.writeAsString('');
    state = AsyncData([]);
  }

  Future<String> getZipFilePath() async {
    var encoder = ZipFileEncoder();
    encoder.create(await generateZipFilePath());
    encoder.addFile(File(await getLoggingFilePath()));
    encoder.close();
    return encoder.zipPath;
  }
}

Future<String> generateZipFilePath() async {
  Directory appDocDirectory = await getTemporaryDirectory();
  return '${appDocDirectory.path}/vaani_logs.zip';
}

Level parseLevel(String level) {
  return Level.LEVELS
      .firstWhere((l) => l.name == level, orElse: () => Level.ALL);
}

LogRecord parseLogLine(String line) {
  // 2024-10-03 00:48:58.012400 INFO GoRouter - getting location for name: "logs"

  final RegExp logLineRegExp = RegExp(
    r'(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{6}) (\w+) (\w+) - (.+)',
  );

  final match = logLineRegExp.firstMatch(line);
  if (match == null) {
    // return as is
    return LogRecord(Level.ALL, line, 'Unknown');
  }

  final timeString = match.group(1)!;
  final levelString = match.group(2)!;
  final loggerName = match.group(3)!;
  final message = match.group(4)!;

  final time = DateTime.parse(timeString);
  final level = parseLevel(levelString);

  return LogRecord(level, message, loggerName, time);
}
