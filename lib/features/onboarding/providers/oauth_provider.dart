import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/models/error_response.dart';

import '../models/flow.dart';

part 'oauth_provider.g.dart';

/// the string state of a flow started by user
typedef State = String;

/// the verifier string of a flow started by user
typedef Verifier = String;

/// the code returned by the oauth provider
typedef Code = String;

@Riverpod(keepAlive: true)
class OauthFlows extends _$OauthFlows {
  @override
  Map<State, Flow> build() {
    return {};
  }

  void addFlow(
    State oauthState, {
    required Verifier verifier,
    required Uri serverUri,
    required Cookie cookie,
    bool replaceExisting = false,
  }) {
    if (state.containsKey(oauthState) && !replaceExisting) {
      return;
    }
    state = {
      ...state,
      oauthState: Flow(
        state: oauthState,
        verifier: verifier,
        serverUri: serverUri,
        cookie: cookie,
        isFlowComplete: false,
      ),
    };
  }

  void markComplete(State oauthState, String? authToken) {
    if (!state.containsKey(oauthState)) {
      return;
    }
    state = {
      ...state,
      oauthState: state[oauthState]!
          .copyWith(isFlowComplete: true, authToken: authToken),
    };
  }
}

/// the code returned by the server in exchange for the verifier
@riverpod
Future<String?> loginInExchangeForCode(
  Ref ref, {
  required State oauthState,
  required Code code,
  ErrorResponseHandler? responseHandler,
}) async {
  final flows = ref.watch(oauthFlowsProvider);
  final flow = flows[oauthState];
  if (flow == null) {
    throw StateError('No flow active for state: $oauthState');
  }

  if (flow.authToken != null) {
    return flow.authToken;
  }

  final api = ref.read(audiobookshelfApiProvider(flow.serverUri));
  final response = await api.server.oauth2Callback(
    code: code,
    codeVerifier: flow.verifier,
    state: oauthState,
    cookie: flow.cookie,
    responseErrorHandler: responseHandler?.storeError,
  );

  if (response == null) {
    return null;
  }

  ref.read(oauthFlowsProvider.notifier).markComplete(oauthState, api.token);
  return api.token;
}
