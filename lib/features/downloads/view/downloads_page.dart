import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/features/downloads/providers/download_manager.dart';

class DownloadsPage extends HookConsumerWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.read(simpleDownloadManagerProvider);
    final downloadHistory = ref.watch(downloadHistoryProvider());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        // history of downloads
        child: downloadHistory.when(
          data: (records) {
            // each group is one list tile, which contains the files downloaded
            final uniqueGroups = records.map((e) => e.group).toSet();
            return ListView.builder(
              itemCount: uniqueGroups.length,
              itemBuilder: (context, index) {
                final group = uniqueGroups.elementAt(index);
                final groupRecords = records.where((e) => e.group == group);
                return ExpansionTile(
                  title: Text(group ?? 'No Group'),
                  children: groupRecords
                      .map(
                        (e) => ListTile(
                          title: Text('${e.task.directory}/${e.task.filename}'),
                          subtitle: Text(e.task.creationTime.toString()),
                        ),
                      )
                      .toList(),
                );
              },
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) {
            return Text('Error: $error');
          },
        ),
      ),
    );
  }
}
