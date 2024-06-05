import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_controller.g.dart';

/// The controller for the search bar.
@Riverpod(keepAlive: true)
class GlobalSearchController extends _$GlobalSearchController {
  @override
  Raw<SearchController> build() {
    final controller = SearchController();
    // dispose the controller when the provider is disposed
    ref.onDispose(controller.dispose);
    return controller;
  }
}
