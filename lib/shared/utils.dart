
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> handleLaunchUrl(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.platformDefault,
    webOnlyWindowName: '_blank',
  )) {
    // throw Exception('Could not launch $url');
    debugPrint('Could not launch $url');
  }
}
