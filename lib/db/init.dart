import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:vaani/main.dart';
import 'package:vaani/settings/constants.dart';

import 'register_models.dart';

// does the initial setup of the storage
Future initStorage() async {
  final dir = await getApplicationDocumentsDirectory();

  // use vaani as the directory for hive
  final storageDir = Directory(
    p.join(
      dir.path,
      AppMetadata.appNameLowerCase,
    ),
  );
  await storageDir.create(recursive: true);

  Hive.defaultDirectory = storageDir.path;
  appLogger.config('Hive storage directory init: ${Hive.defaultDirectory}');

  await registerModels();
}
