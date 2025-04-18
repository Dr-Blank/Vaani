
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vaani/features/logging/providers/logs_provider.dart';
import 'package:vaani/main.dart';

class LogsPage extends HookConsumerWidget {
  const LogsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(logsProvider);
    final theme = Theme.of(context);
    final scrollController = useScrollController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
        actions: [
          IconButton(
            tooltip: 'Clear logs',
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              // ask for confirmation
              final shouldClear = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Clear logs?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  );
                },
              );
              if (shouldClear == true) {
                ref.read(logsProvider.notifier).clear();
              }
            },
          ),
          IconButton(
            tooltip: 'Share logs',
            icon: const Icon(Icons.share),
            onPressed: () async {
              appLogger.info('Preparing logs for sharing');
              final zipLogFilePath =
                  await ref.read(logsProvider.notifier).getZipFilePath();

              // submit logs
              final result = await Share.shareXFiles([XFile(zipLogFilePath)]);

              switch (result.status) {
                case ShareResultStatus.success:
                  appLogger.info('Share success');
                  break;
                case ShareResultStatus.dismissed:
                  appLogger.info('Share dismissed');
                  break;
                case ShareResultStatus.unavailable:
                  appLogger.severe('Share unavailable');
                  break;
              }
            },
          ),

          // downloads disabled since manage external storage permission was removed
          // see https://gitlab.com/IzzyOnDroid/repo/-/issues/623#note_2240386369
          // IconButton(
          //   tooltip: 'Download logs',
          //   icon: const Icon(Icons.download),
          //   onPressed: () async {
          //     appLogger.info('Preparing logs for download');

          //     if (Platform.isAndroid) {
          //       final androidVersion =
          //           await ref.watch(deviceSdkVersionProvider.future);

          //       if ((int.parse(androidVersion)) > 29) {
          //         final status = await Permission.storage.status;
          //         if (!status.isGranted) {
          //           appLogger
          //               .info('Requesting storage permission');
          //           final newStatus =
          //               await Permission.storage.request();
          //           if (!newStatus.isGranted) {
          //             appLogger
          //                 .warning('storage permission denied');
          //             ScaffoldMessenger.of(context).showSnackBar(
          //               const SnackBar(
          //                 content: Text('Storage permission denied'),
          //               ),
          //             );
          //             return;
          //           }
          //         }
          //       } else {
          //         final status = await Permission.storage.status;
          //         if (!status.isGranted) {
          //           appLogger.info('Requesting storage permission');
          //           final newStatus = await Permission.storage.request();
          //           if (!newStatus.isGranted) {
          //             appLogger.warning('Storage permission denied');
          //             ScaffoldMessenger.of(context).showSnackBar(
          //               const SnackBar(
          //                 content: Text('Storage permission denied'),
          //               ),
          //             );
          //             return;
          //           }
          //         }
          //       }
          //     }
          //     final zipLogFilePath =
          //         await ref.read(logsProvider.notifier).getZipFilePath();

          //     // save to folder
          //     String? outputFile = await FilePicker.platform.saveFile(
          //       dialogTitle: 'Please select an output file:',
          //       fileName: zipLogFilePath.split('/').last,
          //       bytes: await File(zipLogFilePath).readAsBytes(),
          //     );
          //     if (outputFile != null) {
          //       try {
          //         final file = File(outputFile);
          //         final zipFile = File(zipLogFilePath);
          //         await zipFile.copy(file.path);
          //         appLogger.info('File saved to: $outputFile');
          //       } catch (e) {
          //         appLogger.severe('Error saving file: $e');
          //       }
          //     } else {
          //       appLogger.info('Download cancelled');
          //     }
          //   },
          // ),
          IconButton(
            tooltip: 'Refresh logs',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(logsProvider);
            },
          ),
          IconButton(
            tooltip: 'Scroll to top',
            icon: const Icon(Icons.arrow_upward),
            onPressed: () {
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
      // a column with ListView.builder and a scrollable list of logs
      body: Column(
        children: [
          // a filter for log levels, loggers, and search
          // TODO: implement filters and search

          Expanded(
            child: logs.when(
              data: (logRecords) {
                return Scrollbar(
                  controller: scrollController,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: logRecords.length,
                    itemBuilder: (context, index) {
                      final logRecord = logRecords[index];
                      return LogRecordTile(logRecord: logRecord, theme: theme);
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Error loading logs'),
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(logsProvider);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogRecordTile extends StatelessWidget {
  final LogRecord logRecord;
  final ThemeData theme;
  const LogRecordTile({
    required this.logRecord,
    required this.theme,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: getLogLevelColor(logRecord.level, theme),
        child: Icon(
          getLogLevelIcon(logRecord.level),
          color: getLogLevelTextColor(logRecord.level, theme),
        ),
      ),
      title: Text(logRecord.loggerName),
      subtitle: Text(logRecord.message),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: Icon(getLogLevelIcon(logRecord.level)),
              title: Text(logRecord.loggerName),
              content: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: logRecord.time.toIso8601String(),
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: logRecord.message,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

IconData getLogLevelIcon(Level level) {
  switch (level) {
    case Level.INFO:
      return (Icons.info);
    case Level.WARNING:
      return (Icons.warning);
    case Level.SEVERE:
    case Level.SHOUT:
      return (Icons.error);
    default:
      return (Icons.bug_report);
  }
}

Color? getLogLevelColor(Level level, ThemeData theme) {
  switch (level) {
    case Level.INFO:
      return theme.colorScheme.surfaceContainerLow;
    case Level.WARNING:
      return theme.colorScheme.surfaceBright;
    case Level.SEVERE:
    case Level.SHOUT:
      return theme.colorScheme.errorContainer;
    default:
      return theme.colorScheme.primaryContainer;
  }
}

Color? getLogLevelTextColor(Level level, ThemeData theme) {
  switch (level) {
    case Level.INFO:
      return theme.colorScheme.onSurface;
    case Level.WARNING:
      return theme.colorScheme.onSurface;
    case Level.SEVERE:
    case Level.SHOUT:
      return theme.colorScheme.onErrorContainer;
    default:
      return theme.colorScheme.onPrimaryContainer;
  }
}
