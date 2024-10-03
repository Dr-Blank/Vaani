import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:vaani/features/logging/providers/logs_provider.dart';

void main() {
  test(
    'Should parse log line',
    () async {
      final formatter = DefaultLogRecordFormatter();
      final logRecord = LogRecord(
        Level.INFO,
        'getting location for name: "logs"',
        'GoRouter',
      );
      final expected = parseLogLine(
        formatter.format(logRecord),
      );
      expect(logRecord.message, expected.message);
      expect(logRecord.level, expected.level);
      expect(logRecord.loggerName, expected.loggerName);
    },
  );
}
