// does the initial setup of the storage

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:whispering_pages/settings/constants.dart';

import 'register_models.dart';

Future initStorage() async {
  final dir = await getApplicationDocumentsDirectory();

  // use whispering_pages as the directory for hive
  final storageDir = Directory(p.join(
    dir.path,
      AppMetadata.appNameLowerCase,
    ),
  );
  await storageDir.create(recursive: true);

  Hive.defaultDirectory = storageDir.path;
  debugPrint('Hive storage directory init: ${Hive.defaultDirectory}');

  await registerModels();
}
