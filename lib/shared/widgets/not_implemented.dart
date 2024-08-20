import 'package:flutter/material.dart';

void showNotImplementedToast(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Not implemented"),
      showCloseIcon: true,
    ),
  );
}
