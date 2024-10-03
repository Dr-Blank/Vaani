import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vaani/shared/extensions/duration_format.dart';

Future<String> getLoggingFilePath() async {
  final Directory directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/vaani.log';
}

Future<void> initLogging() async {
  final formatter = const DefaultLogRecordFormatter();
  if (kReleaseMode) {
    Logger.root.level = Level.INFO; // is also the default
    // Write to a file
    RotatingFileAppender(
      baseFilePath: await getLoggingFilePath(),
      formatter: formatter,
    ).attachToLogger(Logger.root);
  } else {
    Logger.root.level = Level.FINE; // Capture all logs
    RotatingFileAppender(
      baseFilePath: await getLoggingFilePath(),
      formatter: formatter,
    ).attachToLogger(Logger.root);
    Logger.root.onRecord.listen((record) {
      // Print log records to the console
      debugPrint(
        '${record.loggerName}: ${record.level.name}: ${record.time.time}: ${record.message}',
      );
    });
  }
}
