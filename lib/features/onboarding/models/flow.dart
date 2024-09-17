import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'flow.freezed.dart';

@freezed
class Flow with _$Flow {
  const factory Flow({
    required Uri serverUri,
    required String state,
    required String verifier,
    required Cookie cookie,
    @Default(false) bool isFlowComplete,
    String? authToken,
  }) = _Flow;
}
